import 'package:flutter/material.dart';
import 'package:flutter_test_project/instances/user.dart';
import 'package:flutter_test_project/screens/profile_page.dart';
import 'package:flutter_test_project/screens/user_profile_page.dart';
import 'package:hive_flutter/adapters.dart';

class AuthProfilePage extends StatefulWidget {
  const AuthProfilePage({super.key});

  @override
  State<AuthProfilePage> createState() => _AuthProfilePageState();
}

class _AuthProfilePageState extends State<AuthProfilePage> {
  User? user;

  @override
  void initState() {
    super.initState();
    findCurrent();
  }

  Future<void> findCurrent() async {
    await Hive.initFlutter();
    final stringBox = await Hive.openBox<String>('currentUser');
    final currentUserEmail = stringBox.get('currentEmail');
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(UserAdapter());
    }

    await Hive.initFlutter();

    final userBox = await Hive.openBox<User>('users');
    user = userBox.get(currentUserEmail);

    setState(() {
      user = userBox.get(currentUserEmail);
    });
  }

  @override
  Widget build(BuildContext context) {
    return user != null ? UserProfilePage(user!) : const MyProfilePage();
  }
}
