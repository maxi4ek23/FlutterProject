import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_test_project/instances/movie.dart';
import 'package:flutter_test_project/service/movie/movie_storage_service.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

abstract class IMovieService {
  Future<List<Movie>> loadMovieList();
}

class MovieService implements IMovieService {
  final IMovieStorageService movieStorageService = MovieStorageService();

  @override
  Future<List<Movie>> loadMovieList() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      if (!Hive.isAdapterRegistered(1)) {
        Hive.registerAdapter(MovieAdapter());
      }
      return movieStorageService.getMoviesFromStorage();
    } else {
      final response = await http.get(Uri.parse('http://10.0.2.2:5050/movies'));
      final List<dynamic> jsonData = jsonDecode(response.body) as List;
      final List<Movie> movieList = jsonData
          .map(
            (e) => Movie.fromJson(e as Map<String, dynamic>),
          )
          .toList();
      return movieList;
    }
  }
}
