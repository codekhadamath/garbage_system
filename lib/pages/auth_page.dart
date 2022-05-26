import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:garbage_system/services/auth_service.dart';
import 'package:garbage_system/services/user_service.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton.icon(
            icon: const Icon(
              FontAwesome5.google,
              size: 18.0,
            ),
            onPressed: () async {
              final credentials = await AuthService.signInWithGoogle();
              UserService.addUser();
            },
            label: const Text('Sign in with Google')),
      ),
    );
  }
}
