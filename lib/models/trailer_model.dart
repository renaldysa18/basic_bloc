class TrailerModel {
  int _id;
  List<_Result> _results;

  TrailerModel.formJson(Map<String, dynamic> parsedJson){
    _id = parsedJson['id'].toInt();
    List<_Result> temp = [];
    for(int i = 0; i < parsedJson['results'].length; i++){
      _Result _result = _Result(parsedJson['results'][i]);
      temp.add(_result);
    }

    _results = temp;
  }

  int get id => _id;
  List<_Result> get results => _results;

}

class _Result {
  String _id;
  String _iso6391;
  String _iso31661;
  String _key;
  String _name;
  String _site;
  int _size;
  String _type;

  _Result(result) {
    _id = result['id'] != null ? result['id'] : "";
    _iso6391 = result['iso_639_1'] != null ? result['iso_639_1'] : "";
    _iso31661 = result['iso_3166_1'] != null ? result['iso_3166_1'] : "";
    _key = result['key'] != null ? result['key'] : "";
    _name = result['name'] != null ? result['name'] : "";
    _site = result['site'] != null ? result['site'] : "";
    _size = result['size'] != null ? result['size'].toInt() : 0;
    _type = result['type'] != null ? result['type'] : "";
  }

  String get id => _id;
  String get iso_639_1 => _iso6391;
  String get iso_3166_1 => _iso31661;
  String get key => _key;
  String get name => _name;
  String get site => _site;
  int get size => _size;
  String get type => _type;
}
