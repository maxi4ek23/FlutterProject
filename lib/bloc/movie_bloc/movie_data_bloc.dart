import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_test_project/bloc/movie_bloc/movie_data_event.dart';
import 'package:flutter_test_project/bloc/movie_bloc/movie_data_state.dart';
import 'package:flutter_test_project/service/movie/movie_service.dart';

class MovieDataBloc extends Bloc<MovieDataEvent, MovieDataState> {
  MovieDataBloc(this.movieService) : super(MovieDataInitial()) {
    on<LoadMovieData>((event, emit) async {
      emit(MovieDataLoading());
      final movies = await movieService.loadMovieList();
      emit(MovieDataLoaded(movies));
    });
  }

  final MovieService movieService;
}
