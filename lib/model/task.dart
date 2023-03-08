import 'package:freezed_annotation/freezed_annotation.dart';

part 'task.freezed.dart';
part 'task.g.dart';

enum TaskStatus { normal, completed, deleted }

@freezed
class Task with _$Task {
  const factory Task({
    required String userId,
    required String title,
    required String description,
    @Default(false) bool isCompleted,
    @Default(false) bool isDeleted,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _Task;

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);
}

extension on Task {
  bool get isCompleted => status == TaskStatus.completed;
  bool get isDeleted => status == TaskStatus.deleted;
  TaskStatus get status {
    if (isDeleted) {
      return TaskStatus.deleted;
    } else if (isCompleted) {
      return TaskStatus.completed;
    } else {
      return TaskStatus.normal;
    }
  }
}
