import 'package:bloc_pattern/blocs/movie_bloc.dart';
import 'package:bloc_pattern/models/item_model.dart';
import 'package:bloc_pattern/ui/movie_detail.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as developer;

class MovieList extends StatefulWidget {
  @override
  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bloc.fetchAllMovie();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Popular Movie"),
      ),
      body: StreamBuilder(
        stream: bloc.allmovies,
        builder: (context, AsyncSnapshot<ItemModel> snapshot) {
          if (snapshot.hasData) {
            developer.log('dataInit', name: 'have data');
            return buildList(snapshot);
          } else if (snapshot.hasError) {
            developer.log('dataInit', name: 'no have data');
            return Text(snapshot.error.toString());
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  ///build list
  Widget buildList(AsyncSnapshot<ItemModel> snapshot) {
    return GridView.builder(
      itemCount: snapshot.data.results.length,
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (BuildContext context, int index) {
        return GridTile(
          child: InkResponse(
            enableFeedback: true,
            child: Image.network(
              'https://image.tmdb.org/t/p/w185${snapshot.data.results[index].poster_path}',
              fit: BoxFit.cover,
            ),
            onTap: () => openDetailMovie(snapshot.data, index),
          ),
        );
      },
    );
  }

  ///open detail movie
  openDetailMovie(ItemModel data, int index){
    Navigator.push(context, MaterialPageRoute(builder: (context){
      return MovieDetail(
        posterUrl: data.results[index].backdrop_path,
        overview: data.results[index].overview,
        title: data.results[index].title,
        voteAverage: data.results[index].vote_average.toDouble(),
        movieId: data.results[index].id.toInt(),
      );
    }));
  }
}
