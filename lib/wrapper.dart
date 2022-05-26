import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:garbage_system/pages/auth_page.dart';
import 'package:garbage_system/pages/welcome_page.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot<User?> user) {
          if (user.connectionState == ConnectionState.waiting) {
            return const Center(child: Text('Loading...'));
          }

          if (user.data == null) {
            return const AuthPage();
          } else {
            return const Welcome();
          }
        },
      ),
    );
  }
}
