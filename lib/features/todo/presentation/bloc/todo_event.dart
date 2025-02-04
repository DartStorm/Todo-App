part of 'todo_bloc.dart';

abstract class TodoEvent {}

class FetchTodos extends TodoEvent {}

class AddTodo extends TodoEvent {
  final TodoModel todo;
  AddTodo(this.todo);
}

class UpdateTodo extends TodoEvent {
  final TodoModel todo;
  UpdateTodo(this.todo);
}

class DeleteTodo extends TodoEvent {
  final String id;
  DeleteTodo(this.id);
}
