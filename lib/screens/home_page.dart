import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_project/bloc/movie_bloc/movie_data_bloc.dart';
import 'package:flutter_test_project/bloc/movie_bloc/movie_data_event.dart';
import 'package:flutter_test_project/bloc/movie_bloc/movie_data_state.dart';
import 'package:flutter_test_project/bloc/test/test_bloc.dart';
import 'package:flutter_test_project/bloc/test/test_state.dart';
import 'package:flutter_test_project/bloc/user_block/user_block.dart';
import 'package:flutter_test_project/bloc/user_block/user_event.dart';
import 'package:flutter_test_project/bloc/user_block/user_state.dart';
import 'package:flutter_test_project/elements/appbar.dart';
import 'package:flutter_test_project/elements/movie_card.dart';
import 'package:flutter_test_project/elements/navbar.dart';

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

  late StreamSubscription subscription;
  late MovieDataBloc movieBloc;
  late UserBloc userBloc;

  final AuthorizationService authorizationService = AuthorizationService();
  final IMovieService movieService = MovieService();
  final IMovieStorageService movieStorageService = MovieStorageService();
  late StreamSubscription subscription;
  late Future<List<Movie>> movieList;


  @override
  void initState() {
    super.initState();

    movieBloc = BlocProvider.of<MovieDataBloc>(context);
    movieBloc.add(LoadMovieData());
    userBloc = BlocProvider.of<UserBloc>(context);
    userBloc.add(FindUser());

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
      body: BlocListener<UserBloc, UserState>(
        listener: (context, state) {
          if (state is UserFindSuccess) {
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
                      'Please check your internet connection and try again.',
                    ),
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
        },
        child: Padding(
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
                    BlocBuilder<TestBloc, TestState>(
                      //bloc: context.read<>(),
                      builder: (context, state) {
                        if(state is TestDeleted) {
                          return Container();
                        } else if(state is TestUpdated) {
                          return Container(
                            height: 270,
                            child: BlocBuilder<MovieDataBloc, MovieDataState>(
                              bloc: movieBloc,
                              builder: (context, state) {
                                if (state is MovieDataLoading) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                                if (state is MovieDataLoaded) {
                                  return ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: state.movies.length,
                                    separatorBuilder: (context, _) =>
                                    const SizedBox(width: 8),
                                    itemBuilder: (context, index) => MovieCard(
                                      movie: state.movies[index],
                                    ),
                                  );
                                }
                                return Container();
                              },
                            ),
                          );
                        }
                        return Container();
                      },)
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const NavBar(),
    );
  }

}
