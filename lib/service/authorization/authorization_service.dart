import 'package:flutter_test_project/instances/user.dart';
import 'package:flutter_test_project/service/authorization/user_storage_service.dart';
import 'package:hive_flutter/adapters.dart';

abstract class IAuthorizationService {
  Future<String?> register(String username, String email, String password);

  Future<bool> login(String email, String password);
}

class AuthorizationService implements IAuthorizationService {
  final IUserStorageService userStorageService = UserStorageService();

  @override
  Future<String?> register(
      String username, String email, String password,) async {
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(UserAdapter());
    }
    if (username.length < 6 || !email.contains('@gmail.com')) {
      return 'Validation Error';
    }
    final existUser = await userStorageService.getUser(email);
    if (existUser != null) {
      return 'User is already exist';
    }
    final User newUser = User(
      username: username,
      email: email,
      password: password,
    );
    await userStorageService.saveUser(newUser);
    return null;
  }

  @override
  Future<bool> login(String email, String password) async {
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(UserAdapter());
    }

    final authUser = await userStorageService.getUser(email);
    if (authUser != null) {
      if (password == authUser.password) {
        await Hive.initFlutter();
        final stringBox = await Hive.openBox<String>('currentUser');
        await stringBox.put('currentEmail', email);
        return true;
      }
    }
    return false;
  }
}
