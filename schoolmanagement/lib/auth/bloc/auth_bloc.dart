import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:schoolmanagement/auth/authService/authProvider.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(authProvider provider)
      : super(const AuthStateUninitialized(isLoading: true)) {
    on<AuthEventInitialize>((event, emit) async {
      await provider.initialize();
      //TO:DO
      //fetch the isLogin boolean from local storage and use that boolean here
      if (provider.isLoggedIn == true) {
        emit(const AuthStateLoggedIn(isLoading: false));
      } else {
        emit(const AuthStateLoggedOut(exception: null, isLoading: false));
      }
    });
    on<AuthEventLogIn>((event, emit) async {
      emit(const AuthStateLoggedOut(
          exception: null, isLoading: true, loadingTxt: 'Logging in'));

      final id = event.id;
      final password = event.password;
      try {
        await provider.login(
          id: id,
          password: password,
        );
        emit(const AuthStateLoggedIn(isLoading: false));
      } on Exception catch (e) {
        emit(AuthStateLoggedOut(exception: e, isLoading: false));
      }
    });
  }
}
