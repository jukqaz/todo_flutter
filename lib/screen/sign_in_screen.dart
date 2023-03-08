import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todo_flutter/repository/auth_repository.dart';
import 'package:todo_flutter/util/platform.dart';

class SignInScreen extends ConsumerWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => Scaffold(
        appBar: AppBar(
          title: const Text('Sign-In'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (isGoogleSignInAvailable) ...[
                ElevatedButton.icon(
                  onPressed: () {
                    final repository = ref.read(authRepositoryProvider);
                    repository.signInWithGoogle();
                  },
                  icon: const FaIcon(FontAwesomeIcons.google),
                  label: const Text('Google Sign-In'),
                ),
                const SizedBox(height: 16.0),
              ],
              if (isAppleSignInAvailable)
                ElevatedButton.icon(
                  onPressed: () {
                    final repository = ref.read(authRepositoryProvider);
                    repository.signInWithApple();
                  },
                  icon: const FaIcon(FontAwesomeIcons.apple),
                  label: const Text('Apple Sign-In'),
                ),
            ],
          ),
        ),
      );
}
