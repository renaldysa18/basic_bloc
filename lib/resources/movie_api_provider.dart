import 'dart:async';
import 'dart:convert';
import 'package:bloc_pattern/models/item_model.dart';
import 'package:http/http.dart' show Client;


class MovieApiProvider {
  Client client = Client();

  final _apiKey = '9764540cc75307bf937adec56fb19821';

  Future<ItemModel> fetchMovieList() async {
    print("get movie list");

    final response = await client
    .get("http://api.themoviedb.org/3/movie/popular?api_key=$_apiKey");

    if (response.statusCode == 200){
      return ItemModel.fromJson(json.decode(response.body));
    }
    else {
      throw Exception('Failed to load post');
    }
  }
}