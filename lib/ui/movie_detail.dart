import 'package:bloc_pattern/blocs/movie_detail_bloc.dart';
import 'package:bloc_pattern/blocs/movie_detail_bloc_provider.dart';
import 'package:bloc_pattern/models/trailer_model.dart';
import 'package:flutter/material.dart';

class MovieDetail extends StatefulWidget {

  final String posterUrl;
  final String overview;
  final String title;
  final double voteAverage;
  final int movieId;

  MovieDetail({
    this.posterUrl,
    this.overview,
    this.title,
    this.voteAverage,
    this.movieId
});

  @override
  _MovieDetailState createState() => _MovieDetailState(movieId);
}

class _MovieDetailState extends State<MovieDetail> {

  MovieDetailBloc bloc;
  final int movieId;

  _MovieDetailState( this.movieId);


  @override
  void didChangeDependencies() {
    bloc = MovieDetailBlocProvider.of(context);
    bloc.fetchTrailersById(movieId);
    print("recreated");
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final poster = widget.posterUrl;
    final voteAverage = widget.voteAverage;
    final overview = widget.overview;
    final title = widget.title;

    return Scaffold(
      body: SafeArea(
        top: false,
        bottom: false,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context,
              bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                expandedHeight: 200.0,
                floating: false,
                pinned: true,
                elevation: 0.0,
                flexibleSpace: FlexibleSpaceBar(
                    background: Image.network(
                      "https://image.tmdb.org/t/p/w500$poster",
                      fit: BoxFit.cover,
                    )),
              ),
            ];
          },
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(margin: EdgeInsets.only(top: 5.0)),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(margin: EdgeInsets.only(top: 8.0,
                    bottom: 8.0)),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.favorite,
                      color: Colors.red,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 1.0,
                          right: 1.0),
                    ),
                    Text(
                      '$voteAverage',
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10.0,
                          right: 10.0),
                    ),
                  ],
                ),
                Container(margin: EdgeInsets.only(top: 8.0,
                    bottom: 8.0)),
                Text(overview),
                Container(margin: EdgeInsets.only(top: 8.0,
                    bottom: 8.0)),
                Text(
                  "Trailer",
                  style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(margin: EdgeInsets.only(top: 8.0,
                    bottom: 8.0)),
                StreamBuilder(
                  stream: bloc.movieTrailers,
                  builder:
                      (context, AsyncSnapshot<Future<TrailerModel>> snapshot) {
                    if (snapshot.hasData) {
                      return FutureBuilder(
                        future: snapshot.data,
                        builder: (context,
                            AsyncSnapshot<TrailerModel> itemSnapShot) {
                          if (itemSnapShot.hasData) {
                            if (itemSnapShot.data.results.length > 0)
                              return trailerLayout(itemSnapShot.data);
                            else
                              return noTrailer(itemSnapShot.data);
                          } else {
                            return Center(child: CircularProgressIndicator());
                          }
                        },
                      );
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ///widget for trailer
  trailerItem(TrailerModel data, int index){
    return Expanded(
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(5.0),
            height: 100,
            color: Colors.grey,
            child: Center(
              child: Icon(
                Icons.play_circle_filled
              ),
            ),
          ),
          Text(
            data.results[index].name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget trailerLayout(TrailerModel data) {
    if (data.results.length > 1) {
      return Row(
        children: <Widget>[
          trailerItem(data, 0),
          trailerItem(data, 1),
        ],
      );
    } else {
      return Row(
        children: <Widget>[
          trailerItem(data, 0),
        ],
      );
    }
  }

  Widget noTrailer(TrailerModel data) {
    return Center(
      child: Container(
        child: Text("No trailer available"),
      ),
    );
  }
}
