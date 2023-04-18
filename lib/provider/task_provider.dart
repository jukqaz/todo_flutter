import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todo_flutter/model/task.dart';
import 'package:uuid/uuid.dart';

part 'task_provider.g.dart';

@riverpod
class CreateTask extends _$CreateTask {
  @override
  Task build() => Task(
        id: const Uuid().v4(),
        email: '',
        title: '',
        description: '',
        createdAt: DateTime.now(),
      );

  void updateTitle(String title) {
    state = state.copyWith(title: title);
  }

  void updateDescription(String description) {
    state = state.copyWith(description: description);
  }

  bool isEnabled() => [state.title, state.description].every((element) => element.trim().isNotEmpty);
}
