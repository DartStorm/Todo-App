import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:todo_app/features/todo/data/models/todo_model.dart';

import '../../domain/repository/todo_repository.dart';

part 'todo_event.dart';
part 'todo_state.dart';

@injectable
class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoRepository _repository;

  TodoBloc(this._repository) : super(TodoLoading()) {
    on<FetchTodos>(_onFetchTodos);
    on<AddTodo>(_onAddTodo);
    on<UpdateTodo>(_onUpdateTodo);
    on<DeleteTodo>(_onDeleteTodo);
  }

  Future<void> _onFetchTodos(event, emit) async {
    try {
      final todosStream = _repository.getTodos();
      await emit.forEach(
        todosStream,
        onData: (todos) => TodoLoaded(todos),
        onError: (_, __) => TodoError('Failed to fetch todos'),
      );
    } catch (e) {
      emit(TodoError(e.toString()));
    }
  }

  Future<void> _onAddTodo(AddTodo event, emit) async {
    try {
      await _repository.addTodo(event.todo);
    } catch (e) {
      emit(TodoError(e.toString()));
    }
  }

  Future<void> _onUpdateTodo(event, emit) async {
    try {
      await _repository.addTodo(event.todo);
    } catch (e) {
      emit(TodoError(e.toString()));
    }
  }

  Future<void> _onDeleteTodo(event, emit) async {
    try {
      await _repository.deleteTodo(event.id);
    } catch (e) {
      emit(TodoError(e.toString()));
    }
  }
}
