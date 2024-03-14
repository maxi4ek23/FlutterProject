import 'package:flutter/material.dart';
import 'package:flutter_test_project/elements/appbar.dart';
import 'package:flutter_test_project/elements/custom_button.dart';
import 'package:flutter_test_project/elements/custom_form.dart';

class MyLoginPage extends StatelessWidget {
  const MyLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
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
            const Column(
              children: [
                Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  'Login to your account',
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: const Column(
                children: [
                  MyCustomForm(
                    isSecured: false,
                    icon: Icon(Icons.email),
                    hintText: 'Type your email',
                  ),
                  SizedBox(height: 30),
                  MyCustomForm(
                    isSecured: true,
                    icon: Icon(Icons.person),
                    hintText: 'Type your password',
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: MyCustomButton(
                buttonText: 'Login',
                textColor: Colors.white,
                buttonColor: Theme.of(context).colorScheme.primary,
                functionPressed: () {},
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text(
                  'Don`t have an account?',
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                GestureDetector(
                  onTap: () => {
                    Navigator.pushNamed(context, '/signup'),
                  },
                  child: const Text(
                    'Sign up',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              height: size.height / 4,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/loginn.png'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
