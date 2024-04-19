//import 'dart:convert';

//import 'package:flutter_test_project/instances/movie.dart';

import 'package:flutter_test_project/instances/movie.dart';

import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 0)
class User {
  User({
    required this.username,
    required this.email,
    required this.password,
    this.watchList = const [],
  });

  @HiveField(0)
  final String username;

  @HiveField(1)
  final String email;

  @HiveField(2)
  final String password;

  @HiveField(3)
  final List<Movie>? watchList;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        email: json['email'] as String,
        username: json['username'] as String,
        password: json['password'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'email': email,
    'username': username,
    'password': password,
  };
}
