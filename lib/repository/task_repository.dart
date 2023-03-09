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
    taskFilter: ref.watch(taskFilterNotifierProvider),
  );
}

@riverpod
Future<Task?> getTask(
  GetTaskRef ref, {
  required String taskId,
}) =>
    ref.watch(taskRepositoryProvider).getTask(taskId);

class TaskRepository {
  const TaskRepository({
    required this.collectionRef,
    required this.taskFilter,
  });

  final CollectionReference<Task> collectionRef;
  final TaskFilter taskFilter;

  Future<Task?> getTask(String taskId) async {
    final snapshot = await collectionRef.where('id', isEqualTo: taskId).get();
    return snapshot.docs.isNotEmpty ? snapshot.docs[0].data() : null;
  }

  Query<Task> getTasks(String? email) {
    var query = collectionRef.where('email', isEqualTo: email);
    if (taskFilter == TaskFilter.uncompleted) {
      query = query.where('isCompleted', isEqualTo: false);
    } else if (taskFilter == TaskFilter.completed) {
      query = query.where('isCompleted', isEqualTo: true);
    }
    return query.orderBy('createdAt', descending: true);
  }

  Future<void> addTask(Task task) async {
    await collectionRef.doc(task.id).set(task);
  }

  Future<void> modifyTask(Task task) async {
    await collectionRef.doc(task.id).set(task);
  }

  Future<void> deleteTask(String id) async {
    await collectionRef.doc(id).delete();
  }
}
