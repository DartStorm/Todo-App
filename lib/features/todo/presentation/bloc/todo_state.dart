part of 'todo_bloc.dart';

sealed class TodoState extends Equatable {
  @override
  List<Object> get props => [];
}

class TodoLoading extends TodoState {}

class TodoLoaded extends TodoState {
  final List<TodoModel> todos;
  TodoLoaded(this.todos);
  @override
  List<Object> get props => [todos];
}

class TodoError extends TodoState {
  final String message;
  TodoError(this.message);
}
