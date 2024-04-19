abstract class UserEvent {}

class UserSignUp extends UserEvent {
  final String username;
  final String email;
  final String password;

  UserSignUp(this.username, this.email, this.password);
}

class FindUser extends UserEvent {}

class LogInUser extends UserEvent {
  final String email;
  final String password;

  LogInUser(this.email, this.password);
}

class Logout extends UserEvent {}
