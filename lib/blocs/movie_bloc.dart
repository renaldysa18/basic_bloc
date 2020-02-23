import 'package:bloc_pattern/models/item_model.dart';
import 'package:bloc_pattern/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class MovieBloc {
  final _repository = Repository();
  final _movieFetcher = PublishSubject<ItemModel>();

  Observable<ItemModel> get allmovies => _movieFetcher.stream;

  fetchAllMovie() async {
    ItemModel itemModel = await _repository.fetchMovies();

    _movieFetcher.sink.add(itemModel);
  }

  dispose(){
    _movieFetcher.close();
  }
}

final bloc = MovieBloc();