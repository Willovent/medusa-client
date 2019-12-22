class Serie {
  Year year;
  Config config;
  String airs;
  String showType;
  List<String> countries;
  List<SeasonCount> seasonCount;
  String lastUpdate;
  String indexer;
  String title;
  List<String> countryCodes;
  String classification;
  bool airsFormatValid;
  Cache cache;
  String status;
  int runtime;
  Id id;
  String network;
  ImdbInfo imdbInfo;
  String language;
  String nextAirDate;
  String type;
  String plot;
  Rating rating;
  List<String> genres;

  Serie(
      {this.year,
      this.config,
      this.airs,
      this.showType,
      this.countries,
      this.seasonCount,
      this.lastUpdate,
      this.indexer,
      this.title,
      this.countryCodes,
      this.classification,
      this.airsFormatValid,
      this.cache,
      this.status,
      this.runtime,
      this.id,
      this.network,
      this.imdbInfo,
      this.language,
      this.nextAirDate,
      this.type,
      this.plot,
      this.rating,
      this.genres});

  Serie.fromJson(Map<String, dynamic> json) {
    year = json['year'] != null ? new Year.fromJson(json['year']) : null;
    config =
        json['config'] != null ? new Config.fromJson(json['config']) : null;
    airs = json['airs'];
    showType = json['showType'];
    countries = json['countries'].cast<String>();
    if (json['seasonCount'] != null) {
      seasonCount = new List<SeasonCount>();
      json['seasonCount'].forEach((v) {
        seasonCount.add(new SeasonCount.fromJson(v));
      });
    }
    lastUpdate = json['lastUpdate'];
    indexer = json['indexer'];
    title = json['title'];
    countryCodes = json['countryCodes'].cast<String>();
    classification = json['classification'];
    airsFormatValid = json['airsFormatValid'];
    cache = json['cache'] != null ? new Cache.fromJson(json['cache']) : null;
    status = json['status'];
    runtime = json['runtime'];
    id = json['id'] != null ? new Id.fromJson(json['id']) : null;
    network = json['network'];
    imdbInfo = json['imdbInfo'] != null
        ? new ImdbInfo.fromJson(json['imdbInfo'])
        : null;
    language = json['language'];
    nextAirDate = json['nextAirDate'];
    type = json['type'];
    plot = json['plot'];
    rating =
        json['rating'] != null ? new Rating.fromJson(json['rating']) : null;
    genres = json['genres'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.year != null) {
      data['year'] = this.year.toJson();
    }
    if (this.config != null) {
      data['config'] = this.config.toJson();
    }
    data['airs'] = this.airs;
    data['showType'] = this.showType;
    data['countries'] = this.countries;
    if (this.seasonCount != null) {
      data['seasonCount'] = this.seasonCount.map((v) => v.toJson()).toList();
    }
    data['lastUpdate'] = this.lastUpdate;
    data['indexer'] = this.indexer;
    data['title'] = this.title;
    data['countryCodes'] = this.countryCodes;
    data['classification'] = this.classification;
    data['airsFormatValid'] = this.airsFormatValid;
    if (this.cache != null) {
      data['cache'] = this.cache.toJson();
    }
    data['status'] = this.status;
    data['runtime'] = this.runtime;
    if (this.id != null) {
      data['id'] = this.id.toJson();
    }
    data['network'] = this.network;
    if (this.imdbInfo != null) {
      data['imdbInfo'] = this.imdbInfo.toJson();
    }
    data['language'] = this.language;
    data['nextAirDate'] = this.nextAirDate;
    data['type'] = this.type;
    data['plot'] = this.plot;
    if (this.rating != null) {
      data['rating'] = this.rating.toJson();
    }
    data['genres'] = this.genres;
    return data;
  }
}

class Year {
  int start;

  Year({this.start});

  Year.fromJson(Map<String, dynamic> json) {
    start = json['start'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['start'] = this.start;
    return data;
  }
}

class Config {
  String location;
  Qualities qualities;
  bool sports;
  bool seasonFolders;
  bool paused;
  Release release;
  bool locationValid;
  bool dvdOrder;
  List<String> aliases;
  bool airByDate;
  int airdateOffset;
  bool scene;
  bool subtitlesEnabled;
  String defaultEpisodeStatus;
  bool anime;

  Config(
      {this.location,
      this.qualities,
      this.sports,
      this.seasonFolders,
      this.paused,
      this.release,
      this.locationValid,
      this.dvdOrder,
      this.aliases,
      this.airByDate,
      this.airdateOffset,
      this.scene,
      this.subtitlesEnabled,
      this.defaultEpisodeStatus,
      this.anime});

  Config.fromJson(Map<String, dynamic> json) {
    location = json['location'];
    qualities = json['qualities'] != null
        ? new Qualities.fromJson(json['qualities'])
        : null;
    sports = json['sports'];
    seasonFolders = json['seasonFolders'];
    paused = json['paused'];
    release =
        json['release'] != null ? new Release.fromJson(json['release']) : null;
    locationValid = json['locationValid'];
    dvdOrder = json['dvdOrder'];
    airByDate = json['airByDate'];
    airdateOffset = json['airdateOffset'];
    scene = json['scene'];
    subtitlesEnabled = json['subtitlesEnabled'];
    defaultEpisodeStatus = json['defaultEpisodeStatus'];
    anime = json['anime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['location'] = this.location;
    if (this.qualities != null) {
      data['qualities'] = this.qualities.toJson();
    }
    data['sports'] = this.sports;
    data['seasonFolders'] = this.seasonFolders;
    data['paused'] = this.paused;
    if (this.release != null) {
      data['release'] = this.release.toJson();
    }
    data['locationValid'] = this.locationValid;
    data['dvdOrder'] = this.dvdOrder;
    data['airByDate'] = this.airByDate;
    data['airdateOffset'] = this.airdateOffset;
    data['scene'] = this.scene;
    data['subtitlesEnabled'] = this.subtitlesEnabled;
    data['defaultEpisodeStatus'] = this.defaultEpisodeStatus;
    data['anime'] = this.anime;
    return data;
  }
}

class Qualities {
  List<int> allowed;
  List<int> preferred;

  Qualities({this.allowed, this.preferred});

  Qualities.fromJson(Map<String, dynamic> json) {
    allowed = json['allowed'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['allowed'] = this.allowed;
    return data;
  }
}

class Release {
  List<String> ignoredWords;
  bool requiredWordsExclude;
  List<String> requiredWords;
  bool ignoredWordsExclude;

  Release(
      {this.ignoredWords,
      this.requiredWordsExclude,
      this.requiredWords,
      this.ignoredWordsExclude});

  Release.fromJson(Map<String, dynamic> json) {
    requiredWordsExclude = json['requiredWordsExclude'];
    ignoredWordsExclude = json['ignoredWordsExclude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['requiredWordsExclude'] = this.requiredWordsExclude;
    data['ignoredWordsExclude'] = this.ignoredWordsExclude;
    return data;
  }
}

class SeasonCount {
  int episodeCount;
  int season;

  SeasonCount({this.episodeCount, this.season});

  SeasonCount.fromJson(Map<String, dynamic> json) {
    episodeCount = json['episodeCount'];
    season = json['season'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['episodeCount'] = this.episodeCount;
    data['season'] = this.season;
    return data;
  }
}

class Cache {
  String banner;
  String poster;

  Cache({this.banner, this.poster});

  Cache.fromJson(Map<String, dynamic> json) {
    banner = json['banner'];
    poster = json['poster'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['banner'] = this.banner;
    data['poster'] = this.poster;
    return data;
  }
}

class Id {
  String slug;
  String trakt;
  String imdb;
  int tvmaze;

  Id({this.slug, this.trakt, this.imdb, this.tvmaze});

  Id.fromJson(Map<String, dynamic> json) {
    slug = json['slug'];
    trakt = json['trakt'];
    imdb = json['imdb'];
    tvmaze = json['tvmaze'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['slug'] = this.slug;
    data['trakt'] = this.trakt;
    data['imdb'] = this.imdb;
    data['tvmaze'] = this.tvmaze;
    return data;
  }
}

class ImdbInfo {
  int year;
  String title;
  int indexer;
  String akas;
  int indexerId;
  int lastUpdate;
  String countries;
  String countryCodes;
  int runtimes;
  String imdbId;
  int imdbInfoId;
  String plot;
  int votes;
  String certificates;
  String rating;
  String genres;

  ImdbInfo(
      {this.year,
      this.title,
      this.indexer,
      this.akas,
      this.indexerId,
      this.lastUpdate,
      this.countries,
      this.countryCodes,
      this.runtimes,
      this.imdbId,
      this.imdbInfoId,
      this.plot,
      this.votes,
      this.certificates,
      this.rating,
      this.genres});

  ImdbInfo.fromJson(Map<String, dynamic> json) {
    year = json['year'];
    title = json['title'];
    indexer = json['indexer'];
    akas = json['akas'];
    indexerId = json['indexerId'];
    lastUpdate = json['lastUpdate'];
    countries = json['countries'];
    countryCodes = json['countryCodes'];
    runtimes = json['runtimes'];
    imdbId = json['imdbId'];
    imdbInfoId = json['imdbInfoId'];
    plot = json['plot'];
    votes = json['votes'];
    certificates = json['certificates'];
    rating = json['rating'];
    genres = json['genres'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['year'] = this.year;
    data['title'] = this.title;
    data['indexer'] = this.indexer;
    data['akas'] = this.akas;
    data['indexerId'] = this.indexerId;
    data['lastUpdate'] = this.lastUpdate;
    data['countries'] = this.countries;
    data['countryCodes'] = this.countryCodes;
    data['runtimes'] = this.runtimes;
    data['imdbId'] = this.imdbId;
    data['imdbInfoId'] = this.imdbInfoId;
    data['plot'] = this.plot;
    data['votes'] = this.votes;
    data['certificates'] = this.certificates;
    data['rating'] = this.rating;
    data['genres'] = this.genres;
    return data;
  }
}

class Rating {
  Imdb imdb;

  Rating({this.imdb});

  Rating.fromJson(Map<String, dynamic> json) {
    imdb = json['imdb'] != null ? new Imdb.fromJson(json['imdb']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.imdb != null) {
      data['imdb'] = this.imdb.toJson();
    }
    return data;
  }
}

class Imdb {
  String rating;
  int votes;

  Imdb({this.rating, this.votes});

  Imdb.fromJson(Map<String, dynamic> json) {
    rating = json['rating'];
    votes = json['votes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rating'] = this.rating;
    data['votes'] = this.votes;
    return data;
  }
}