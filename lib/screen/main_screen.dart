import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_flutter/repository/auth_repository.dart';

class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => Scaffold(
        appBar: AppBar(
          title: const Text('Main'),
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () async {
                final repository = ref.read(authRepositoryProvider);
                repository.signOut();
              },
            ),
            const SizedBox(width: 12.0),
          ],
        ),
        body: const Center(child: Text('Main Screen')),
      );
}
