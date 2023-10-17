part of 'auth_bloc.dart';

@immutable
abstract class AuthState {
  final bool isLoading;
  final String? loadingText;
  const AuthState({required this.isLoading, this.loadingText});
}

class AuthStateUninitialized extends AuthState {
  const AuthStateUninitialized({required bool isLoading})
      : super(isLoading: isLoading);
}

class AuthStateLoggedIn extends AuthState {
  const AuthStateLoggedIn({
    required bool isLoading,
  }) : super(isLoading: isLoading);
}

class AuthStateLoggedOut extends AuthState with EquatableMixin {
  final Exception? exception;
  const AuthStateLoggedOut({
    required this.exception,
    required bool isLoading,
    String? loadingTxt,
  }) : super(
          isLoading: isLoading,
          loadingText: loadingTxt,
        );

  @override
  List<Object?> get props => [exception, isLoading];
}
