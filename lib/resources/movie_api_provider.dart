import 'dart:async';
import 'dart:convert';
import 'package:bloc_pattern/models/item_model.dart';
import 'package:bloc_pattern/models/trailer_model.dart';
import 'package:http/http.dart' show Client;


class MovieApiProvider {
  Client client = Client();

  final _apiKey = '9764540cc75307bf937adec56fb19821';
  final _baseUrl = 'http://api.themoviedb.org/3/movie';

  Future<ItemModel> fetchMovieList() async {
    print("get movie list");

    final response = await client
    .get("$_baseUrl/popular?api_key=$_apiKey");

    if (response.statusCode == 200){
      return ItemModel.fromJson(json.decode(response.body));
    }
    else {
      throw Exception('Failed to load post');
    }
  }

  Future<TrailerModel> fetchTrailerMovie(int movieId) async {
    final response = await client.get("$_baseUrl/$movieId/videos?api_key=$_apiKey");

    if(response.statusCode == 200){
      return TrailerModel.formJson(json.decode(response.body));
    }
    else {
      throw Exception('failed to load trailer');
    }
  }
}