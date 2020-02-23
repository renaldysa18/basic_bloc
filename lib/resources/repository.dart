import 'package:bloc_pattern/models/item_model.dart';
import 'package:bloc_pattern/resources/movie_api_provider.dart';

class Repository {
  final movieApiProvider = MovieApiProvider();

  Future<ItemModel> fetchMovies() => movieApiProvider.fetchMovieList();
}