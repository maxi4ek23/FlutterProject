import 'package:flutter_test_project/instances/movie.dart';
import 'package:hive_flutter/adapters.dart';

abstract class IMovieStorageService {
  Future<List<Movie>> getMoviesFromStorage();
}

class MovieStorageService implements IMovieStorageService {
  @override
  Future<List<Movie>> getMoviesFromStorage() async {
    await Hive.initFlutter();

    final movieBox = await Hive.openBox<Movie>('movie');

    return movieBox.values.toList();
  }
}
