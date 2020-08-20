import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:medusa_client/models/api-state.model.dart';
import 'package:medusa_client/models/episode.model.dart';
import 'package:http/http.dart' as http;

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
             iconTheme: IconThemeData(
              color: serie.dominantColor.titleTextColor,
            ),
            bottom: TabBar(
              labelColor: serie.dominantColor.bodyTextColor,
              isScrollable: serie.seasonCount.length > 4,
              tabs: [
                Tab(text: 'Details'),
                ...serie.seasonCount.map((i) => Tab(text: 'S${i.season}'))
              ],
            ),
            title: Text(serie.title ,style: TextStyle(color: serie.dominantColor.titleTextColor)),
            backgroundColor: serie.dominantColor.color,
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
              CachedNetworkImage(
                  imageUrl:
                      '${apiState.apiUrl}/api/v2/series/${serie.id.slug}/asset/posterThumb?api_key=${apiState.apiKey}',
                  placeholder: (context, url) => CircularProgressIndicator(),
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
      child: CachedNetworkImage(
        imageUrl:
            '${apiState.apiUrl}/api/v2/series/${serie.id.slug}/asset/fanart?api_key=${apiState.apiKey}',
      ),
    ),
    Card(
      elevation: 5,
      semanticContainer: true,
      margin: EdgeInsets.all(8),
      child: CachedNetworkImage(
        imageUrl:
            '${apiState.apiUrl}/api/v2/series/${serie.id.slug}/asset/banner?api_key=${apiState.apiKey}',
      ),
    )
  ]);
}

Widget seasonTab(Serie serie, ApiState apiState, SeasonCount season) {
  return SeasonTab(apiState: apiState, season: season.season, serie: serie);
}

class SeasonTab extends StatefulWidget {
  final Serie serie;
  final int season;
  final ApiState apiState;

  SeasonTab({this.serie, this.season, this.apiState});

  @override
  SeasonState createState() => SeasonState(
      serie: this.serie, season: this.season, apiState: this.apiState);
}

class SeasonState extends State<SeasonTab> {
  Serie serie;
  int season;
  ApiState apiState;
  List<Episode> _episodes;

  SeasonState({this.serie, this.season, this.apiState});

  _loadEpisode() async {
    try {
      var response = await http.get(
          '${apiState.apiUrl}/api/v2/series/${serie.id.slug}/episodes?season=$season&limit=1000',
          headers: {'X-Api-Key': apiState.apiKey});

      List<Episode> episodes = [];
      for (var episode in json.decode(response.body)) {
        episodes.add(Episode.fromJson(episode));
      }
      episodes.sort((y, x) => x.episode > y.episode ? 0 : 1);
      if (mounted)
        setState(() {
          _episodes = episodes;
        });
    } catch (error) {
      if (mounted)
        setState(() {
          _episodes = [];
        });
    }
  }

  @override
  void initState() {
    super.initState();
    _loadEpisode();
  }

  @override
  Widget build(BuildContext context) {
    return _episodes == null
        ? Center(child: CircularProgressIndicator())
        : ListView.separated(
            itemCount: _episodes?.length ?? 0,
            itemBuilder: (context, index) =>
                EpisodeItem(episode: _episodes[index]),
            separatorBuilder: (context, index) => Divider(),
          );
  }
}

class EpisodeItem extends StatelessWidget {
  final Episode episode;
  EpisodeItem({this.episode});

  @override
  Widget build(BuildContext context) {
    var aireDate = episode.airDate != null
        ? DateFormat.yMMMMd().format(DateTime.parse(episode.airDate))
        : 'unknown';

    return Padding(
        padding: EdgeInsets.all(8),
        child: Row(
          children: <Widget>[
            Column(
              children: <Widget>[
                Text(
                  'E${episode.episode} - ${episode.title}',
                  style: TextStyle(fontSize: 15),
                ),
                Text('$aireDate'),
                Container(
                    color: statusToColor(episode),
                    child: Padding(
                        padding: EdgeInsets.all(2),
                        child: Text('${episode.status}',
                            style: TextStyle(
                              fontSize: 12,
                            ))))
              ],
              crossAxisAlignment: CrossAxisAlignment.start,
            )
          ],
        ));
  }
}

Color statusToColor(Episode episode) {
  switch (episode.status.toLowerCase()) {
    case 'archived':
    case 'downloaded':
      return Colors.green.shade500;
    case 'ignored':
    case 'skipped':
      return Colors.blue.shade500;
    case 'snatched':
    case 'snatched (proper)':
      return Colors.purple.shade800;
    case "unaired":
      return Colors.yellow.shade900;
    case "wanted":
      return Colors.red.shade800;
  }
  return Colors.blue.shade500;
}
