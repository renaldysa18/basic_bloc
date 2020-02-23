import 'package:bloc_pattern/models/trailer_model.dart';
import 'package:bloc_pattern/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class MovieDetailBloc {

  final _repository = Repository();
  final _movieId = PublishSubject<int>();
  final _trailer = BehaviorSubject<Future<TrailerModel>>();

  Function(int) get fetchTrailersById => _movieId.sink.add;
  Observable<Future<TrailerModel>> get movieTrailers => _trailer.stream;

  MovieDetailBloc(){
    _movieId.stream.transform(_itemTransformer()).pipe(_trailer);
  }

  dispose() async {
    _movieId.close();
    await _trailer.drain();
    _trailer.close();
  }

  _itemTransformer(){
    return ScanStreamTransformer(
        (Future<TrailerModel> trailer, int id, int index){
          trailer = _repository.fetchTrailerMovie(id);
          return trailer;
        }
    );
  }
}