import 'package:flutter/material.dart';
import 'package:flutter_test_project/instances/user.dart';
import 'package:flutter_test_project/screens/profile_page.dart';
import 'package:flutter_test_project/screens/user_profile_page.dart';
import 'package:flutter_test_project/service/api/api_service.dart';
import 'package:flutter_test_project/service/authorization/authorization_service.dart';

class AuthProfilePage extends StatefulWidget {
  const AuthProfilePage({super.key});

  @override
  State<AuthProfilePage> createState() => _AuthProfilePageState();
}

class _AuthProfilePageState extends State<AuthProfilePage> {
  final AuthorizationService authorizationService = AuthorizationService();
  final IApiService apiService = ApiService();
  User? currUser;
  User? user;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  Future<void> getCurrentUser() async {
    currUser = await authorizationService.findCurrentUser();
    showCurrentUser();
  }

  void showCurrentUser() {
    setState(() {
      user = currUser;
    });
  }

  @override
  Widget build(BuildContext context) {
    return user != null ? UserProfilePage(user!) : const MyProfilePage();
  }
}
