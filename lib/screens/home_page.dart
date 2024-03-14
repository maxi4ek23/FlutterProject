//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/widgets.dart';

import 'package:flutter_test_project/data.dart';
import 'package:flutter_test_project/elements/appbar.dart';
import 'package:flutter_test_project/elements/movie_card.dart';
import 'package:flutter_test_project/elements/navbar.dart';

//import 'package:flutter_test_project/instances/movie.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      //backgroundColor: const Color.fromRGBO(235, 225, 247, 1),
      appBar: const MyAppBar(
        isAbleGoBack: false,
        appTitle: 'Welcome to MovieLand',
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 25),
        child: Container(
          height: size.height,
          child: Column(
            children: [
              Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 8),
                    child: Row(
                      //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'Now Showing',
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
                    height: 260,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: movies.length,
                      separatorBuilder: (context, _) =>
                          const SizedBox(width: 8),
                      itemBuilder: (context, index) =>
                          MovieCard(movie: movies[index]),
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
