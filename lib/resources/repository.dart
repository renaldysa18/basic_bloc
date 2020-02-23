import 'package:bloc_pattern/models/item_model.dart';
import 'package:bloc_pattern/models/trailer_model.dart';
import 'package:bloc_pattern/resources/movie_api_provider.dart';

class Repository {
  final movieApiProvider = MovieApiProvider();

  ///for list movie popular
  Future<ItemModel> fetchMovies() => movieApiProvider.fetchMovieList();

  ///for trailer movie
  Future<TrailerModel> fetchTrailerMovie(int movieId) => movieApiProvider.fetchTrailerMovie(movieId);

}