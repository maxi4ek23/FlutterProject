import 'package:flutter/material.dart';
import 'package:flutter_test_project/elements/appbar.dart';
import 'package:flutter_test_project/elements/movie_card.dart';
import 'package:flutter_test_project/elements/navbar.dart';
import 'package:flutter_test_project/instances/user.dart';

class UserProfilePage extends StatefulWidget {
  final User user;

  const UserProfilePage(this.user, {super.key});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        isAbleGoBack: false,
        appTitle: widget.user.username,
      ),
      body: Container(
        height: 270,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: widget.user.watchList!.length,
          separatorBuilder: (context, _) => const SizedBox(width: 8),
          itemBuilder: (context, index) => MovieCard(
            movie: widget.user.watchList![index],
          ),
        ),
      ),
      bottomNavigationBar: const NavBar(),
    );
  }
}
