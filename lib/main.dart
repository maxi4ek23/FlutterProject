import 'package:flutter/material.dart';
import 'package:flutter_test_project/screens/favourite_page.dart';
import 'package:flutter_test_project/screens/home_page.dart';
import 'package:flutter_test_project/screens/login_page.dart';
import 'package:flutter_test_project/screens/profile_page.dart';
import 'package:flutter_test_project/screens/search_page.dart';
import 'package:flutter_test_project/screens/signup_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo App',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromRGBO(235, 225, 247, 1),
        appBarTheme: const AppBarTheme(
          color: Color.fromRGBO(63, 0, 92, 1),
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
        ),
        //colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromRGBO
        //(235, 225, 247, 1),),
        //primarySwatch: Colors.purple,
        //primaryColor: const Color.fromRGBO(63, 0, 92, 1),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.purple,
          secondary: const Color.fromRGBO(235, 225, 247, 1),
          primary: const Color.fromRGBO(63, 0, 92, 1),
        ),
      ),
      //home: const MyHomePage(title: 'Flutter Demo App Home Page'),
      routes: {
        '/': (context) => const MyHomePage(),
        '/search': (context) => const MySearchPage(),
        '/favourite': (context) => const MyFavouritePage(),
        '/profile': (context) => const MyProfilePage(),
        '/login': (context) => const MyLoginPage(),
        '/signup': (context) => const MySignUpPage(),
      },
      initialRoute: '/',
    );
  }
}
