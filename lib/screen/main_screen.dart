import 'dart:math';

import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_flutter/model/task.dart';
import 'package:todo_flutter/provider/top_level_providers.dart';
import 'package:todo_flutter/repository/auth_repository.dart';
import 'package:todo_flutter/repository/task_repository.dart';
import 'package:todo_flutter/widget/no_tasks.dart';
import 'package:uuid/uuid.dart';

class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(firebaseAuthProvider).currentUser!;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Main'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => ref.read(authRepositoryProvider).signOut(),
          ),
          const SizedBox(width: 12.0),
        ],
      ),
      body: FirestoreListView<Task>(
        query: ref.watch(taskRepositoryProvider).getTasks(user.uid),
        loadingBuilder: (context) => const Center(child: CupertinoActivityIndicator()),
        errorBuilder: (context, _, __) => const NoTasks(),
        emptyBuilder: (context) => const NoTasks(),
        itemBuilder: (context, doc) {
          final task = doc.data();
          return DecoratedBox(
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.white38, width: 1.0)),
            ),
            child: ListTile(
              key: ObjectKey(task),
              title: Text(task.title),
              subtitle: Text(task.description),
              trailing: Text('Created at: ${task.createdAt}'),
              tileColor: task.isCompleted ? Colors.white24 : Theme.of(context).primaryColor,
              onTap: () => context.push('/task/${task.id}'),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(taskRepositoryProvider).addTask(
                Task(
                  id: const Uuid().v4(),
                  userId: user.uid,
                  title: 'New task ${Random().nextInt(10000)}',
                  description: 'New task description ${Random().nextInt(10000)}',
                  createdAt: DateTime.now(),
                ),
              );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
