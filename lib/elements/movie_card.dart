import 'package:flutter/material.dart';

import 'package:flutter_test_project/instances/movie.dart';

class MovieCard extends StatefulWidget {
  final Movie movie;

  const MovieCard({
    required this.movie,
    super.key,
  });

  @override
  State<MovieCard> createState() => _MovieCardState();
}

class _MovieCardState extends State<MovieCard> {
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
              widget.movie.urlImg,
              width: 180,
              height: 220,
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 2, 0, 0),
                  child: Text(
                    widget.movie.movieName,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                      border: Border.all(
                    color: Colors.red,
                    width: 2,
                  ),),
                  child: MaterialButton(
                      onPressed: () {},
                      child: const Icon(
                        Icons.save,
                      ),),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
