import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/features/todo/data/models/todo_model.dart';

import '../../../../core/helper_utils/date_time_utils.dart';
import '../bloc/todo_bloc.dart';

class TodoItem extends StatelessWidget {
  final TodoModel todo;

  const TodoItem(this.todo, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ListTile(
        horizontalTitleGap: 0,
        contentPadding: EdgeInsets.zero,
        leading: Checkbox(
          value: todo.isCompleted,
          onChanged: (_) => context
              .read<TodoBloc>()
              .add(UpdateTodo(todo.copyWith(isCompleted: !todo.isCompleted!))),
        ),
        title: Text(
          todo.title ?? "",
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              decoration: (todo.isCompleted ?? false)
                  ? TextDecoration.lineThrough
                  : TextDecoration.none),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              todo.description ?? "",
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
            Text(
              formatedDate(todo.date),
              style: TextStyle(fontWeight: FontWeight.w400),
            ),
          ],
        ),
        trailing: IconButton(
            onPressed: () {
              _showDeleteConfirmationDialog(context);
            },
            icon: Icon(Icons.delete)),
        onLongPress: () => context.read<TodoBloc>().add(DeleteTodo(todo.id!)),
      ),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Are you sure?'),
          content: Text('Do you really want to delete this todo?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('No'),
            ),
            TextButton(
              onPressed: () {
                context.read<TodoBloc>().add(DeleteTodo(todo.id!));
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Yes'),
            ),
          ],
        );
      },
    );
  }
}
