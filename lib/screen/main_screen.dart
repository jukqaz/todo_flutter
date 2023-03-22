import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_flutter/extension/context_extension.dart';
import 'package:todo_flutter/model/task.dart';
import 'package:todo_flutter/provider/task_provider.dart';
import 'package:todo_flutter/repository/auth_repository.dart';
import 'package:todo_flutter/repository/task_repository.dart';
import 'package:todo_flutter/widget/no_tasks.dart';
import 'package:todo_flutter/widget/task_item.dart';

class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => Scaffold(
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
          query: ref.watch(taskRepositoryProvider).getTasks(ref.watch(getEmailProvider)),
          loadingBuilder: (context) => const Center(child: CupertinoActivityIndicator()),
          errorBuilder: (context, error, __) => Center(child: Text('$error')),
          emptyBuilder: (context) => const NoTasks(),
          itemBuilder: (context, doc) => TaskItem(task: doc.data()),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => showModalBottomSheet(
            context: context,
            enableDrag: false,
            isDismissible: true,
            builder: (context) => const Padding(
              padding: EdgeInsets.all(20.0),
              child: _CreateTaskForm(),
            ),
          ),
          child: const Icon(Icons.add),
        ),
      );
}

class _CreateTaskForm extends ConsumerWidget {
  const _CreateTaskForm();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final task = ref.watch(createTaskProvider);

    return Column(
      children: [
        TextField(
          autofocus: true,
          decoration: const InputDecoration(hintText: 'Task title'),
          textInputAction: TextInputAction.next,
          maxLength: 30,
          onChanged: ref.read(createTaskProvider.notifier).updateTitle,
        ),
        const SizedBox(height: 16.0),
        TextField(
          decoration: const InputDecoration(hintText: 'Task description'),
          minLines: 3,
          maxLines: 3,
          maxLength: 500,
          onChanged: ref.read(createTaskProvider.notifier).updateDescription,
        ),
        const SizedBox(height: 16.0),
        Expanded(
          child: Center(
            child: SizedBox(
              width: context.mediaSize.width / 2,
              child: ElevatedButton(
                onPressed: ref.watch(createTaskProvider.notifier).isEnabled
                    ? () async {
                        final goRouter = GoRouter.of(context);
                        final scaffoldMessenger = ScaffoldMessenger.of(context);
                        try {
                          await ref
                              .read(taskRepositoryProvider)
                              .addTask(task.copyWith(email: ref.read(getEmailProvider)));

                          scaffoldMessenger.showSnackBar(const SnackBar(content: Text('Successfully added task')));
                        } catch (e) {
                          scaffoldMessenger.showSnackBar(
                            SnackBar(content: Text('Failure adding task: $e'), backgroundColor: Colors.redAccent),
                          );
                        }

                        goRouter.pop();
                      }
                    : null,
                child: const Text('OK'),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
