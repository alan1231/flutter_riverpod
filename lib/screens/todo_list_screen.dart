import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../todo.dart';
import '../todolist.dart';
import '../widgets/todo_list_tile.dart';

class TodoListScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoList = ref.watch(todoListProvider);

    return ListView(
      children: _buildTodoList(ref, todoList),
    );
  }

  List<Widget> _buildTodoList(WidgetRef ref, List<Todo> todoList) {
    return todoList.map((todo) {
      return TodoListTile(
        todo: todo,
        onToggle: () => ref.read(todoListProvider.notifier).toggle(todo.id),
        onDelete: () => ref.read(todoListProvider.notifier).remove(todo.id),
      );
    }).toList();
  }
}