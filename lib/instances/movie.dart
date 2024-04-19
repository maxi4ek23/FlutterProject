
import 'package:hive/hive.dart';

part 'movie.g.dart';

@HiveType(typeId: 1)
class Movie {
  @HiveField(0)
  final String movieName;

  @HiveField(1)
  final String urlImg;

  Movie({required this.movieName, required this.urlImg});

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      movieName: json['name'] as String,
      urlImg: json['url'] as String,
    );
  }
}
