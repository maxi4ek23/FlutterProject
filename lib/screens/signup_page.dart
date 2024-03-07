import 'package:flutter/material.dart';
import 'package:flutter_test_project/elements/appbar.dart';
import 'package:flutter_test_project/elements/custom_button.dart';
import 'package:flutter_test_project/elements/custom_form.dart';
import 'package:flutter_test_project/elements/custom_title.dart';

class MySignUpPage extends StatefulWidget {
  const MySignUpPage({super.key});

  @override
  State<MySignUpPage> createState() => _MySignUpPageState();
}

class _MySignUpPageState extends State<MySignUpPage> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: const MyAppBar(
          isAbleGoBack: true,
          appTitle: 'MovieLand',
        ),
        body: Container(
          width: double.infinity,
          padding: const EdgeInsets.only(top: 15),
          height: size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const MyTitleAndSubtitle(
                mainTitle: 'Sign up',
                subTitle:
                    'Create an account! And get to know the world of MovieLand',
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: const Column(
                  children: [
                    MyCustomForm(
                      isSecured: false,
                      icon: Icon(Icons.verified_user),
                      hintText: 'Type your username',
                    ),
                    SizedBox(height: 15),
                    MyCustomForm(
                      isSecured: false,
                      icon: Icon(Icons.email),
                      hintText: 'Type your email',
                    ),
                    SizedBox(height: 15),
                    MyCustomForm(
                      isSecured: true,
                      icon: Icon(Icons.person),
                      hintText: 'Type your passord',
                    ),
                    SizedBox(height: 15),
                    MyCustomForm(
                      isSecured: true,
                      icon: Icon(Icons.person),
                      hintText: 'Confirm your password',
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: MyCustomButton(
                  buttonText: 'Sign up',
                  textColor: Colors.white,
                  buttonColor: Theme.of(context).colorScheme.primary,
                  functionPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
