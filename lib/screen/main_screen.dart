import 'dart:math';

import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_flutter/model/task.dart';
import 'package:todo_flutter/provider/top_level_providers.dart';
import 'package:todo_flutter/repository/auth_repository.dart';
import 'package:todo_flutter/repository/task_repository.dart';
import 'package:todo_flutter/widget/no_tasks.dart';
import 'package:todo_flutter/widget/task_item.dart';
import 'package:uuid/uuid.dart';

class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final email = ref.watch(firebaseAuthProvider).currentUser?.email;

    return Scaffold(
      appBar: AppBar(
        title: Text('Tasks - ${ref.watch(taskFilterNotifierProvider).name.toUpperCase()}'),
        centerTitle: false,
        actions: [
          PopupMenuButton(
            icon: const Icon(Icons.menu),
            itemBuilder: (context) => [
              PopupMenuItem(
                onTap: () => ref.read(taskFilterNotifierProvider.notifier).update(TaskFilter.all),
                child: const Text('All'),
              ),
              PopupMenuItem(
                onTap: () => ref.read(taskFilterNotifierProvider.notifier).update(TaskFilter.uncompleted),
                child: const Text('Uncompleted'),
              ),
              PopupMenuItem(
                onTap: () => ref.read(taskFilterNotifierProvider.notifier).update(TaskFilter.completed),
                child: const Text('Completed'),
              ),
            ],
          ),
          const SizedBox(width: 12.0),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => ref.read(authRepositoryProvider).signOut(),
          ),
          const SizedBox(width: 12.0),
        ],
      ),
      body: FirestoreListView<Task>(
        query: ref.watch(taskRepositoryProvider).getTasks(email),
        loadingBuilder: (context) => const Center(child: CupertinoActivityIndicator()),
        errorBuilder: (context, error, __) => Center(child: Text('$error')),
        emptyBuilder: (context) => const NoTasks(),
        itemBuilder: (context, doc) => TaskItem(task: doc.data()),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => ref.read(taskRepositoryProvider).addTask(
              Task(
                id: const Uuid().v4(),
                email: email,
                title: 'New task ${Random().nextInt(10000)}',
                description: 'New task description ${Random().nextInt(10000)}',
                createdAt: DateTime.now(),
              ),
            ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
