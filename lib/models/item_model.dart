class ItemModel {
  int _page;
  int _totalResults;
  int _totalPages;
  List<Result> _results;

  ItemModel.fromJson(Map<String, dynamic> parsedJson) {
    print(parsedJson['results'].length);
    _page = parsedJson['page'];
    _totalResults = parsedJson['total_results'];
    _totalPages = parsedJson['total_pages'];
    List<Result> temp = [];
    for (int i = 0; i < parsedJson['results'].length; i++) {
      Result result = Result(parsedJson['results'][i]);
      temp.add(result);
    }
    _results = temp;
  }

  List<Result> get results => _results;

  int get total_results => _totalResults;

  int get total_pages => _totalPages;

  int get page => _page;

}

class Result {
  double _popularity;
  int _voteCount;
  bool _video;
  String _posterPath;
  int _id;
  bool _adult;
  String _backdropPath;
  String _title;
  double _voteAverage;
  String _overview;

  Result(result) {
    _popularity = result['popularity'];
    _voteCount = result['vote_count'];
    _video = result['video'];
    _posterPath = result['poster_path'];
    _id = result['id'];
    _adult = result['adult'] ? null : false;
    _backdropPath = "${result['backdrop_path'] ?? ""}";
    _title = "${result['title'] ?? ""}";
    _overview = "${result['overview'] ?? ""}";
  }

  double get popularity => _popularity;

  int get vote_count => _voteCount;

  bool get video => _video;

  String get poster_path => _posterPath;

  int get id => _id;

  bool get adult => _adult;

  String get backdrop_path => _backdropPath;

  String get title => _title;

  double get vote_average => _voteAverage;

  String get overview => _overview;

}
