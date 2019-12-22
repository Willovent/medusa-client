import 'package:medusa_client/models/serie.model.dart';

class Episode {
  List<String> subtitles;
  Id id;
  String identifier;
  Release release;
  String description;
  Scene scene;
  int season;
  String slug;
  String title;
  bool watched;
  int episode;
  File file;
  int quality;
  String status;
  Content content;
  String airDate;

  Episode(
      {this.subtitles,
      this.id,
      this.identifier,
      this.release,
      this.description,
      this.scene,
      this.season,
      this.slug,
      this.title,
      this.watched,
      this.episode,
      this.file,
      this.quality,
      this.status,
      this.content,
      this.airDate});

  Episode.fromJson(Map<String, dynamic> json) {
    subtitles = json['subtitles'].cast<String>();
    id = json['id'] != null ? new Id.fromJson(json['id']) : null;
    identifier = json['identifier'];
    release =
        json['release'] != null ? new Release.fromJson(json['release']) : null;
    description = json['description'];
    scene = json['scene'] != null ? new Scene.fromJson(json['scene']) : null;
    season = json['season'];
    slug = json['slug'];
    title = json['title'];
    watched = json['watched'];
    episode = json['episode'];
    file = json['file'] != null ? new File.fromJson(json['file']) : null;
    quality = json['quality'];
    status = json['status'];
    content =
        json['content'] != null ? new Content.fromJson(json['content']) : null;
    airDate = json['airDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subtitles'] = this.subtitles;
    if (this.id != null) {
      data['id'] = this.id.toJson();
    }
    data['identifier'] = this.identifier;
    if (this.release != null) {
      data['release'] = this.release.toJson();
    }
    data['description'] = this.description;
    if (this.scene != null) {
      data['scene'] = this.scene.toJson();
    }
    data['season'] = this.season;
    data['slug'] = this.slug;
    data['title'] = this.title;
    data['watched'] = this.watched;
    data['episode'] = this.episode;
    if (this.file != null) {
      data['file'] = this.file.toJson();
    }
    data['quality'] = this.quality;
    data['status'] = this.status;
    if (this.content != null) {
      data['content'] = this.content.toJson();
    }
    data['airDate'] = this.airDate;
    return data;
  }
}

class Release {
  String group;
  bool proper;
  String name;
  int version;

  Release({this.group, this.proper, this.name, this.version});

  Release.fromJson(Map<String, dynamic> json) {
    group = json['group'];
    proper = json['proper'];
    name = json['name'];
    version = json['version'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['group'] = this.group;
    data['proper'] = this.proper;
    data['name'] = this.name;
    data['version'] = this.version;
    return data;
  }
}

class Scene {
  int season;
  int episode;

  Scene({this.season, this.episode});

  Scene.fromJson(Map<String, dynamic> json) {
    season = json['season'];
    episode = json['episode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['season'] = this.season;
    data['episode'] = this.episode;
    return data;
  }
}

class File {
  String location;
  String name;
  int size;

  File({this.location, this.name, this.size});

  File.fromJson(Map<String, dynamic> json) {
    location = json['location'];
    name = json['name'];
    size = json['size'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['location'] = this.location;
    data['name'] = this.name;
    data['size'] = this.size;
    return data;
  }
}

class Content {
  bool hasNfo;
  bool hasTbn;

  Content({this.hasNfo, this.hasTbn});

  Content.fromJson(Map<String, dynamic> json) {
    hasNfo = json['hasNfo'];
    hasTbn = json['hasTbn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['hasNfo'] = this.hasNfo;
    data['hasTbn'] = this.hasTbn;
    return data;
  }
}
