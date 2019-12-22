import 'package:flutter/material.dart';
import 'package:medusa_client/models/api-state.model.dart';

import 'models/serie.model.dart';

class SeriePage extends StatelessWidget {
  final Serie serie;
  final ApiState apiState;

  SeriePage({Key key, this.serie, this.apiState}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    {
      return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.directions_car)),
                Tab(icon: Icon(Icons.directions_transit)),
                Tab(icon: Icon(Icons.directions_bike)),
              ],
            ),
            title: Text(serie.title),
          ),
          body: TabBarView(
            children: [
              mainCard(serie, apiState),
              Icon(Icons.directions_transit),
              Icon(Icons.directions_bike),
            ],
          ),
        ),
      );
    }
  }
}

Widget mainCard(Serie serie, ApiState apiState) {
  return Column(children: <Widget>[
    Card(
        elevation: 5,
        clipBehavior: Clip.antiAlias,
        semanticContainer: false,
        margin: EdgeInsets.all(8),
        child: Container(
            height: 160,
            child: Row(children: <Widget>[
              Image.network(
                  '${apiState.apiUrl}/api/v2/series/${serie.id.slug}/asset/posterThumb?api_key=${apiState.apiKey}',
                  fit: BoxFit.fill),
              Padding(
                  padding: EdgeInsets.all(12),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(serie.title, style: TextStyle(fontSize: 20)),
                        Text(serie.network, style: TextStyle(fontSize: 14)),
                        Text(serie.status, style: TextStyle(fontSize: 14))
                      ]))
            ])))
  ]);
}
