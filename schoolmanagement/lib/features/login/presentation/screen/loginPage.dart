import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schoolmanagement/auth/authService/authException.dart';
import 'package:schoolmanagement/auth/bloc/auth_bloc.dart';
import 'package:schoolmanagement/features/home/presentation/widget/widget.dart';

class loginPage extends StatefulWidget {
  const loginPage({super.key});

  @override
  State<loginPage> createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthStateLoggedOut) {
          //Todo: show error dialogs
          if (state.exception is userNotFoundAuthException ||
              state.exception is wrongPasswordAuthException) {
            CustomSnackBar.show(
              context: context,
              message: 'User Not Found!',
              timeInSeconds: 2,
            );
          } else if (state.exception is genericAuthException) {
            CustomSnackBar.show(
              context: context,
              message: 'An Error Occured. Please try later!',
              timeInSeconds: 2,
            );
          }
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 20),
              TextField(
                controller: usernameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter your id',
                ),
              ),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter your password',
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // Respond to button press
                  final id = usernameController.text.trim();
                  final password = passwordController.text.trim();
                  context
                      .read<AuthBloc>()
                      .add(AuthEventLogIn(id: id, password: password));
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
