// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/loading.dart';
import 'package:medusa_client/menu.dart';
import 'package:medusa_client/models/api-state.model.dart';
import 'package:medusa_client/serie.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'models/serie.model.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
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

  Future<void> _loadSeries() async {
    var response = await http
        .get('${_apiState.apiUrl}/api/v2/series', headers: {'X-Api-Key': _apiState.apiKey});

    List<Serie> series = [];
    for (var serie in json.decode(response.body)) {
      series.add(Serie.fromJson(serie));
    }

    setState(() {
      _series = series;
    });
  }

  _getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var apiUrl = prefs.get('apiUrl') ?? '';
    var apiKey = prefs.get('apiKey') ?? '';
    _apiState = ApiState(apiUrl: apiUrl, apiKey: apiKey);
    await _loadSeries();
  }

  @override
  initState() {
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    Widget body;
    if (_series != null) {
      body = ListView.separated(
        itemCount: _series.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
              height: 80,
              child: Padding(
                  child: InkWell(
                      child: Row(children: [
                        Image.network(
                            '${_apiState.apiUrl}/api/v2/series/${_series[index].id.slug}/asset/posterThumb?api_key=${_apiState.apiKey}',
                            fit: BoxFit.fill),
                        Padding(
                            padding: const EdgeInsets.all(8),
                            child: Text(_series[index].title))
                      ]),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  SeriePage(serie: _series[index],apiState: _apiState),
                            ));
                      }),
                  padding: const EdgeInsets.only(left: 8, right: 8)));
        },
        separatorBuilder: (BuildContext context, int index) =>
            const Divider(thickness: 1),
      );
    } else {
      body = Center(
          child: Loading(
              indicator: BallPulseIndicator(), size: 50.0, color: Colors.blue));
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Series list'),
      ),
      body: body,
      drawer: AppMenu(),
    );
  }
}
