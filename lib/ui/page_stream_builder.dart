import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc_movies/bloc/movie_bloc.dart';
import 'package:flutter_bloc_movies/bloc/movie_provider.dart';
import 'package:flutter_bloc_movies/state/movie_state.dart';
import 'package:flutter_bloc_movies/ui/empty_result_widget.dart';
import 'package:flutter_bloc_movies/ui/movies_error_widget.dart';
import 'package:flutter_bloc_movies/ui/movies_list_stateful_widget.dart';
import 'package:flutter_bloc_movies/ui/movies_loading_widget.dart';
import 'package:flutter_bloc_movies/utils/TabConstants.dart';

// ignore: must_be_immutable
class PageStreamBuilder extends StatelessWidget {
  MovieBloc movieBloc;

//  var moviesList = new MovieListStatefulWidget();

  @override
  Widget build(BuildContext context) {
    movieBloc = MovieProvider.of(context);

    return Column(children: [
      Flexible(
          child:
              buildStreamBuilder(TabKey.kNowPlaying, TabKey.kNowPlaying.index))
    ]);
  }

  StreamBuilder<MoviesState> buildStreamBuilder(TabKey tabKey, int tabIndex) {
    return StreamBuilder(
        stream: movieBloc.stream,
        builder: (context, snapshot) {
          final data = snapshot.data;
          return Column(
            children: <Widget>[
              FlatButton(onPressed: getNextPage, child: Text("GET NEXT PAGE")),
              Expanded(
                child: Stack(
                  children: <Widget>[
                    // Fade in an Empty Result screen if the search contained
                    // no items
                    EmptyWidget(visible: data is MoviesEmpty),

                    // Fade in a loading screen when results are being fetched
                    MoviesLoadingWidget(visible: data is MoviesLoading),

                    // Fade in an error if something went wrong when fetching
                    // the results
                    MoviesErrorWidget(
                        visible: data is MoviesError,
                        error: data is MoviesError ? data.error : ""),

                    // Fade in the Result if available
                    MovieListStatefulWidget(
                        movieBloc: movieBloc,
                        tabKey: tabKey,
                        movies: data is MoviesPopulated ? data.movies : []),
                  ],
                ),
              ),
            ],
          );
        });
  }

  void getNextPage() {
    print('get next page');
    movieBloc.fetchNextPage();
  }
}
