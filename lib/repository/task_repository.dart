import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todo_flutter/model/task.dart';

part 'task_repository.g.dart';

@riverpod
TaskRepository taskRepository(TaskRepositoryRef ref) {
  return TaskRepository(
    collectionRef: FirebaseFirestore.instance.collection('tasks').withConverter<Task>(
          fromFirestore: (snapshot, _) => Task.fromJson(snapshot.data()!),
          toFirestore: (task, _) => task.toJson(),
        ),
  );
}

class TaskRepository {
  const TaskRepository({required this.collectionRef});

  final CollectionReference<Task> collectionRef;

  Query<Task> getTasks(String userId) =>
      collectionRef.where('userId', isEqualTo: userId).orderBy('createdAt', descending: true);

  Future<void> addTask(Task task) async {
    await collectionRef.add(task);
  }

  Future<void> modifyTask(Task task) async {
    await collectionRef.doc(task.id).set(task);
  }

  Future<void> deleteTask(String id) async {
    await collectionRef.doc(id).delete();
  }
}
