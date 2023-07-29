part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {
  const AuthEvent();
}

class AuthEventInitialize extends AuthEvent {
  const AuthEventInitialize();
}

class AuthEventLogIn extends AuthEvent {
  final String id;
  final String password;
  const AuthEventLogIn({required this.id, required this.password});
}

class AuthEventLogOut extends AuthEvent {
  const AuthEventLogOut();
}
