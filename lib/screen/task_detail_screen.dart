import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_flutter/model/task.dart';
import 'package:todo_flutter/repository/task_repository.dart';
import 'package:todo_flutter/widget/no_task_detail.dart';

class TaskDetailScreen extends ConsumerWidget {
  const TaskDetailScreen({
    super.key,
    required this.taskId,
  });

  final String taskId;

  @override
  Widget build(BuildContext context, WidgetRef ref) => Scaffold(
        appBar: AppBar(
          title: const Text('Task Detail'),
        ),
        body: ref.watch(getTaskProvider(taskId: taskId)).when(
              loading: () => const Center(child: CircularProgressIndicator()),
              data: (task) => task == null ? const NoTaskDetail() : _TaskDetail(task),
              error: (_, __) => const NoTaskDetail(),
            ),
      );
}

class _TaskDetail extends StatelessWidget {
  const _TaskDetail(this.task);

  final Task task;

  @override
  Widget build(BuildContext context) => Center(
        child: Text(task.title),
      );
}
