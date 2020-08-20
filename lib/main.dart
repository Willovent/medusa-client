// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/loading.dart';
import 'package:medusa_client/menu.dart';
import 'package:medusa_client/models/api-state.model.dart';
import 'package:medusa_client/serie.dart';
import 'package:medusa_client/settings.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app.notifier.dart';
import 'models/serie.model.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primaryColor: Colors.green,
          brightness: Brightness.dark,
          accentColor: Colors.green[900]),
      home: MyHomePage(title: 'Medusa'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<MyHomePage> {
  List<Serie> _series;
  ApiState _apiState;

  bool _notConfigured = false;

  bool _hasError = false;

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch
    await _loadSeries();

    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    await _getData();
    _refreshController.loadComplete();
  }

  Future<void> _loadSeries() async {
    try {
      var response = await http.get(
          '${_apiState.apiUrl}/api/v2/series?limit=1000',
          headers: {'X-Api-Key': _apiState.apiKey});

      List<Serie> series = [];
      for (var serie in json.decode(response.body)) {
        var serieObj = Serie.fromJson(serie);
        series.add(serieObj);
        try {
          var poster = NetworkImage(
              '${_apiState.apiUrl}/api/v2/series/${serieObj.id.slug}/asset/posterThumb?api_key=${_apiState.apiKey}');
          var paletteGenerator = await PaletteGenerator.fromImageProvider(
            poster,
            size: Size(210.0, 295.0),
            region: Offset.zero & Size(210.0, 295.0),
            maximumColorCount: 3,
          );
          serieObj.dominantColor = paletteGenerator.dominantColor;
        } catch (e) {
          debugPrint(e.toString());
        }
      }

      setState(() {
        _series = series;
      });
      _hasError = false;
    } catch (error) {
      setState(() {
        _hasError = true;
        _series = [];
      });
      _refreshController.loadFailed();
    }
  }

  _getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String apiUrl = prefs.get('apiUrl') ?? '';
    String apiKey = prefs.get('apiKey') ?? '';
    if (apiKey.isEmpty || apiUrl.isEmpty) {
      setState(() {
        _notConfigured = true;
        _hasError = false;
      });
    } else {
      _apiState = ApiState(apiUrl: apiUrl, apiKey: apiKey);
      setState(() {
        _notConfigured = false;
      });
      await _loadSeries();
    }
  }

  @override
  initState() {
    super.initState();
    apiStateNotifer.addListener(() {
      if (mounted) {
        _getData();
      }
    });
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    Widget body;
    body = _notConfigured
        ? Center(
            child: RaisedButton(
            elevation: 6,
            child: Text('Click to configure your medusa server'),
            padding: EdgeInsets.all(20),
            color: Theme.of(context).accentColor,
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SettingsPage()));
            },
          ))
        : _hasError
            ? Text('Error loading series')
            : _series == null
                ? Center(
                    child: Loading(
                    indicator: BallPulseIndicator(),
                    size: 50.0,
                  ))
                : SmartRefresher(
                    enablePullDown: true,
                    header: ClassicHeader(),
                    controller: _refreshController,
                    onRefresh: _onRefresh,
                    onLoading: _onLoading,
                    child: ListView.separated(
                      itemCount: _series?.length ?? 0,
                      itemBuilder: (BuildContext context, int index) {
                        return SerieItem(
                            apiState: _apiState, serie: _series[index]);
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          const Divider(thickness: 1),
                    ),
                  );

    return Scaffold(
      appBar: AppBar(
        title: Text('Series list'),
      ),
      body: body,
      drawer: AppMenu(),
    );
  }
}

class SerieItem extends StatelessWidget {
  const SerieItem({
    Key key,
    @required ApiState apiState,
    @required Serie serie,
  })  : _apiState = apiState,
        _serie = serie,
        super(key: key);

  final ApiState _apiState;
  final Serie _serie;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 80,
        child: Padding(
            child: InkWell(
                child: Row(children: [
                  CachedNetworkImage(
                      height: 80,
                      width: 52,
                      imageUrl:
                          '${_apiState.apiUrl}/api/v2/series/${_serie.id.slug}/asset/posterThumb?api_key=${_apiState.apiKey}',
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                      fit: BoxFit.fill),
                  Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(_serie.title))
                ]),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            SeriePage(serie: _serie, apiState: _apiState),
                      ));
                }),
            padding: const EdgeInsets.only(left: 8, right: 8)));
  }
}
