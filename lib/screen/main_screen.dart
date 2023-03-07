import 'package:flutter/material.dart';
import 'package:todo_flutter/repository/auth_repository.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Main'),
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () async {
                final repository = AuthRepository();
                repository.signOut();
              },
            ),
            SizedBox(width: 12.0),
          ],
        ),
        body: const Center(child: Text('Main Screen')),
      );
}
