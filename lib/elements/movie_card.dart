import 'package:flutter/material.dart';

import 'package:flutter_test_project/instances/movie.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;

  const MovieCard({
    required this.movie,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
      child: Container(
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.white,
            ),
          ],
        ),
        child: Column(
          children: [
            Image.asset(
              movie.urlImg,
              width: 180,
              height: 220,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 6, 0, 0),
              child: Text(
                movie.movieName,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
