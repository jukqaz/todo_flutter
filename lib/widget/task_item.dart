import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_flutter/model/task.dart';
import 'package:todo_flutter/repository/task_repository.dart';

class TaskItem extends ConsumerWidget {
  const TaskItem({super.key, required this.task});

  final Task task;

  @override
  Widget build(BuildContext context, WidgetRef ref) => DecoratedBox(
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.white38, width: 1.0)),
        ),
        child: Slidable(
          key: Key(task.id),
          endActionPane: ActionPane(
            motion: const StretchMotion(),
            children: [
              SlidableAction(
                onPressed: (_) => ref.watch(taskRepositoryProvider).deleteTask(task.id),
                backgroundColor: Colors.redAccent,
                foregroundColor: Colors.white,
                icon: Icons.delete,
                label: 'Delete',
              ),
              if (task.isCompleted)
                SlidableAction(
                  onPressed: (_) => ref.watch(taskRepositoryProvider).modifyTask(
                        task.copyWith(isCompleted: false, updatedAt: DateTime.now()),
                      ),
                  backgroundColor: Colors.amber.shade400,
                  foregroundColor: Colors.white,
                  icon: Icons.undo,
                  label: 'Uncompleted',
                )
              else
                SlidableAction(
                  onPressed: (_) => ref.watch(taskRepositoryProvider).modifyTask(
                        task.copyWith(isCompleted: true, updatedAt: DateTime.now()),
                      ),
                  backgroundColor: Colors.lightGreen,
                  foregroundColor: Colors.white,
                  icon: Icons.done,
                  label: 'Completed',
                ),
            ],
          ),
          child: ListTile(
            title: Text(
              task.title,
              maxLines: 1,
              style: const TextStyle(overflow: TextOverflow.ellipsis),
            ),
            subtitle: Text(
              task.description,
              maxLines: 1,
              style: const TextStyle(overflow: TextOverflow.ellipsis),
            ),
            trailing: Text('Created at: ${task.createdAt}'),
            tileColor: task.isCompleted ? Colors.white24 : Theme.of(context).primaryColor,
            onTap: () => context.push('/task/${task.id}'),
          ),
        ),
      );
}
