import 'package:todo_app/features/todo/data/models/todo_model.dart';

abstract class TodoRepository {
  Stream<List<TodoModel>> getTodos();
  Future<void> addTodo(TodoModel todo);
  Future<void> updateTodo(TodoModel todo);
  Future<void> deleteTodo(String id);
}
