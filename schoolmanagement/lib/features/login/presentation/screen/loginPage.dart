import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schoolmanagement/auth/authService/authException.dart';
import 'package:schoolmanagement/auth/bloc/auth_bloc.dart';

import 'package:schoolmanagement/features/home/presentation/widget/widget.dart';
import 'package:schoolmanagement/features/login/presentation/widget/loginButton.dart';
import 'package:schoolmanagement/features/login/presentation/widget/textfield.dart';

import 'package:gap/gap.dart';

class loginPage extends StatefulWidget {
  const loginPage({super.key});

  @override
  State<loginPage> createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isPassShown = false;
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
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Center(
                  child: Text(
                    "Login",
                    style: TextStyle(
                      color: Color(0xFF966AC0),
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Gap(20),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: Image.network(
                      'https://img.freepik.com/free-vector/ok-concept-illustration_114360-2039.jpg?w=1380&t=st=1699675494~exp=1699676094~hmac=f502746d26befea0234fce6fb4e9329b1dba20abef972a085074dfefaf2948e8'),
                ),
                LoginTextField(
                  suffixIconData: Icons.person,
                  text: 'Username...',
                  controller: usernameController,
                ),
                LoginTextField(
                    suffixIconData: isPassShown
                        ? Icons.remove_red_eye
                        : Icons.password_sharp, //TO:DO  need a better icon
                    onSuffixIconTap: () {
                      setState(() {
                        isPassShown = !isPassShown;
                      });
                    },
                    text: 'Password...',
                    controller: passwordController,
                    isPassword: !isPassShown),
                const Gap(15),
                LoginButton(
                    text: 'Login',
                    onPressed: () {
                      // Respond to button press
                      final id = usernameController.text.trim();
                      final password = passwordController.text.trim();
                      context
                          .read<AuthBloc>()
                          .add(AuthEventLogIn(id: id, password: password));
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
