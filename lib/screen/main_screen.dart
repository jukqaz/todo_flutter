import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_flutter/model/task.dart';
import 'package:todo_flutter/repository/auth_repository.dart';
import 'package:todo_flutter/screen/error_screen.dart';

final tasksQuery =
    FirebaseFirestore.instance.collection('tasks').orderBy('createdAt', descending: true).withConverter<Task>(
          fromFirestore: (snapshot, _) => Task.fromJson(snapshot.data()!),
          toFirestore: (task, _) => task.toJson(),
        );

class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => Scaffold(
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
          query: tasksQuery,
          loadingBuilder: (context) => const CupertinoActivityIndicator(),
          errorBuilder: (context, error, _) => ErrorScreen(message: Exception(error)),
          emptyBuilder: (context) => const Center(child: Text('No tasks')),
          itemBuilder: (context, doc) {
            final task = doc.data();
            return ListTile(
              title: Text(task.title),
              subtitle: Text(task.description),
              tileColor: task.isCompleted ? Colors.green : Colors.white,
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            final user = FirebaseAuth.instance.currentUser;
            if (user == null) return;

            FirebaseFirestore.instance
                .collection('tasks')
                .withConverter<Task>(
                  fromFirestore: (snapshot, _) => Task.fromJson(snapshot.data()!),
                  toFirestore: (task, _) => task.toJson(),
                )
                .add(
                  Task(
                    title: 'title22',
                    userId: user.uid,
                    description: 'description',
                    createdAt: DateTime.now(),
                  ),
                );
          },
          child: const Icon(Icons.add),
        ),
      );
}
