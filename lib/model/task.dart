import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'task.freezed.dart';
part 'task.g.dart';

@freezed
class Task with _$Task {
  const factory Task({
    required String id,
    required String? email,
    required String title,
    required String description,
    @Default(false) bool isCompleted,
    @Default(false) bool isDeleted,
    required DateTime createdAt,
    DateTime? updatedAt,
  }) = _Task;

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);
}

enum TaskFilter {
  all,
  uncompleted,
  completed,
}

@riverpod
class TaskFilterNotifier extends _$TaskFilterNotifier {
  @override
  TaskFilter build() => TaskFilter.all;

  void update(TaskFilter filter) => state = filter;
}
