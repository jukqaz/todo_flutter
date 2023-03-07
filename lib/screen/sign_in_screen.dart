import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todo_flutter/repository/auth_repository.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Sign-In'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (!Platform.isMacOS) ...[
                ElevatedButton.icon(
                  onPressed: () {
                    final repository = AuthRepository();
                    repository.signInWithGoogle();
                  },
                  icon: FaIcon(FontAwesomeIcons.google),
                  label: Text('Google Sign-In'),
                ),
                SizedBox(height: 16.0),
              ],
              if (Platform.isIOS || Platform.isMacOS)
                ElevatedButton.icon(
                  onPressed: () {
                    final repository = AuthRepository();
                    repository.signInWithApple();
                  },
                  icon: FaIcon(FontAwesomeIcons.apple),
                  label: Text('Apple Sign-In'),
                ),
            ],
          ),
        ),
      );
}
