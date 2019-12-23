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
        length: serie.seasonCount.length + 1,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              isScrollable: serie.seasonCount.length > 4,
              tabs: [
                Tab(text: 'Details'),
                ...List.generate(
                    serie.seasonCount.length, (i) => Tab(text: 'S${i + 1}'))
              ],
            ),
            title: Text(serie.title),
          ),
          body: TabBarView(
            children: [
              mainTab(serie, apiState),
              ...List.generate(serie.seasonCount.length,
                  (i) => seasonTab(serie, apiState, serie.seasonCount[i]))
            ],
          ),
        ),
      );
    }
  }
}

Widget mainTab(Serie serie, ApiState apiState) {
  return ListView(children: <Widget>[
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
            ]))),
    Card(
        elevation: 5,
        semanticContainer: true,
        margin: EdgeInsets.all(8),
        child: Container(
          height: 160,
          child: Padding(
              padding: EdgeInsets.all(12),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Language : ${serie.language}',
                        style: TextStyle(fontSize: 14)),
                    Text('Subtitles: ${serie.config.subtitlesEnabled}',
                        style: TextStyle(fontSize: 14)),
                    Text('Location : ${serie.config.location}',
                        style: TextStyle(fontSize: 14)),
                    Text(serie.genres.join(', '),
                        style: TextStyle(fontSize: 14))
                  ])),
        )),
    Card(
      elevation: 5,
      semanticContainer: true,
      margin: EdgeInsets.all(8),
      child: Image.network(
          '${apiState.apiUrl}/api/v2/series/${serie.id.slug}/asset/fanart?api_key=${apiState.apiKey}'),
    ),
    Card(
      elevation: 5,
      semanticContainer: true,
      margin: EdgeInsets.all(8),
      child: Image.network(
          '${apiState.apiUrl}/api/v2/series/${serie.id.slug}/asset/banner?api_key=${apiState.apiKey}'),
    )
  ]);
}

Widget seasonTab(Serie serie, ApiState apiState, SeasonCount season) {
  return Text('Season ${season.season} has ${season.episodeCount} episodes');
}
