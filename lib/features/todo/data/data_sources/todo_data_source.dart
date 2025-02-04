abstract class TodoRemoteDataSource {
  Stream<List<Map<String, dynamic>>> getTodos();
  Future<void> addTodo(Map<String, dynamic> todo);
  Future<void> updateTodo(Map<String, dynamic> todo);
  Future<void> deleteTodo(String id);
}