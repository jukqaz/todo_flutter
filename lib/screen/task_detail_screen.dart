import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_flutter/extension/context_extension.dart';
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
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              task.title,
              style: const TextStyle(
                fontSize: 60.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20.0),
            Expanded(
              child: Container(
                width: context.mediaQuery.size.width,
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(border: Border.all(color: Colors.white24)),
                child: SingleChildScrollView(
                  child: Text(
                    task.description,
                    style: const TextStyle(fontSize: 40.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}
