import 'package:flutter_test_project/instances/movie.dart';

abstract class MovieDataState {}

class MovieDataInitial extends MovieDataState {}

class MovieDataLoading extends MovieDataState {}

class MovieDataLoaded extends MovieDataState {
  final List<Movie> movies;

  MovieDataLoaded(this.movies);
}
