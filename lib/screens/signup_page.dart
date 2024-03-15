import 'package:flutter/material.dart';
import 'package:flutter_test_project/elements/appbar.dart';
import 'package:flutter_test_project/elements/custom_button.dart';
import 'package:flutter_test_project/elements/custom_form.dart';
import 'package:flutter_test_project/elements/custom_title.dart';
import 'package:flutter_test_project/service/authorization/authorization_service.dart';

class MySignUpPage extends StatefulWidget {
  const MySignUpPage({super.key});

  @override
  State<MySignUpPage> createState() => _MySignUpPageState();
}

class _MySignUpPageState extends State<MySignUpPage> {
  final passwordController = TextEditingController();
  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final AuthorizationService authorizationService = AuthorizationService();

  void finallyRegister() async {
    final username = userNameController.text;
    final password = passwordController.text;
    final email = emailController.text;

    final registrationResult = await authorizationService.register(
      username,
      email,
      password,
    );
    if (registrationResult != null) {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('non-existent user'),
          content: const Text('Invalid email or password. Please try again.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, 'Hi'),
              child: const Text('Ok'),
            ),
          ],
        ),
      );
    } else {
      Navigator.pushNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: const MyAppBar(
          isAbleGoBack: true,
          appTitle: 'MovieLand',
        ),
        body: Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
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
                child: Column(
                  children: [
                    MyCustomForm(
                      validator: (value) {
                        if (value!.length < 6) {
                          return 'Username should consist at least 6 symbols';
                        }
                        return null;
                      },
                      controller: userNameController,
                      isSecured: false,
                      icon: const Icon(Icons.verified_user),
                      hintText: 'Type your username',
                    ),
                    const SizedBox(height: 15),
                    MyCustomForm(
                      validator: (value) {
                        if (!value!.contains('@gmail.com')) {
                          return 'Use only gmail';
                        }
                        return null;
                      },
                      controller: emailController,
                      isSecured: false,
                      icon: const Icon(Icons.email),
                      hintText: 'Type your email',
                    ),
                    const SizedBox(height: 15),
                    MyCustomForm(
                      controller: passwordController,
                      isSecured: true,
                      icon: const Icon(Icons.person),
                      hintText: 'Type your password',
                    ),
                    const SizedBox(height: 15),
                    MyCustomForm(
                      validator: (value) {
                        if (value != passwordController.text) {
                          return 'Type the same password';
                        }
                        return null;
                      },
                      isSecured: true,
                      icon: const Icon(Icons.person),
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
                  functionPressed: finallyRegister,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
