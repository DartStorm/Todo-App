import 'package:injectable/injectable.dart';
import 'package:todo_app/features/todo/data/models/todo_model.dart';

import '../../domain/repository/todo_repository.dart';
import '../data_sources/todo_data_source.dart';

@LazySingleton(as: TodoRepository)
class TodoRepositoryImpl implements TodoRepository {
  final TodoRemoteDataSource _remoteDataSource;

  TodoRepositoryImpl(this._remoteDataSource);

  @override
  Stream<List<TodoModel>> getTodos() {
    return _remoteDataSource.getTodos().map((todoList) =>
        todoList.map((todo) => TodoModel.fromJson(todo)).toList());
  }

  @override
  Future<void> addTodo(TodoModel todo) async {
    await _remoteDataSource.addTodo(todo.toJson());
  }

  @override
  Future<void> updateTodo(TodoModel todo) async {
    await _remoteDataSource.updateTodo(todo.toJson());
  }

  @override
  Future<void> deleteTodo(String id) async {
    await _remoteDataSource.deleteTodo(id);
  }
}
