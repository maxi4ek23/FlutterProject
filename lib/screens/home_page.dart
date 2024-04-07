import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_project/elements/appbar.dart';
import 'package:flutter_test_project/elements/movie_card.dart';
import 'package:flutter_test_project/elements/navbar.dart';
import 'package:flutter_test_project/instances/movie.dart';
import 'package:flutter_test_project/service/authorization/authorization_service.dart';
import 'package:flutter_test_project/service/movie/movie_service.dart';
import 'package:flutter_test_project/service/movie/movie_storage_service.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final AuthorizationService authorizationService = AuthorizationService();
  final IMovieService movieService = MovieService();
  final IMovieStorageService movieStorageService = MovieStorageService();
  late StreamSubscription subscription;
  late Future<List<Movie>> movieList;

  @override
  void initState() {
    super.initState();
    movieList = movieService.loadMovieList();
    checkIfLogin();
  }

  @override
  void dispose() {
    super.dispose();
    subscription.cancel();
  }


  Future<void> checkIfLogin() async {
    final currUser = await authorizationService.findCurrentUser();
    if (currUser != null) {
      subscription = Connectivity()
          .onConnectivityChanged
          .listen((ConnectivityResult result) {
        final hasInternet = result != ConnectivityResult.none;
        if (!hasInternet) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('No network connection'),
              content: const Text(
                'Please check your internet connection and try again.',),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('OK'),
                ),
              ],
            ),
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: const MyAppBar(
        isAbleGoBack: false,
        appTitle: 'Welcome to MovieLand',
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 25, 10, 0),
        child: Container(
          height: size.height,
          child: Column(
            children: [
              Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 8),
                    child: Row(
                      children: [
                        Text(
                          'Now showing',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        Spacer(),
                        Text('See more'),
                      ],
                    ),
                  ),
                  Container(
                    height: 270,
                    child: FutureBuilder(
                      future: movieList,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          final movies = snapshot.data!;
                          return ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: movies.length,
                            separatorBuilder: (context, _) =>
                            const SizedBox(width: 8),
                            itemBuilder: (context, index) => MovieCard(
                              movie: movies[index],
                            ),
                          );
                        } else {
                          return const Center();
                        }
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const NavBar(),
    );
  }

}
