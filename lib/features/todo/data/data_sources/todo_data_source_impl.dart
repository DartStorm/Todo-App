import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/features/todo/data/data_sources/todo_data_source.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: TodoRemoteDataSource)
class TodoRemoteDataSourceImpl implements TodoRemoteDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Stream<List<Map<String, dynamic>>> getTodos() {
    return _firestore
        .collection('todos')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }

  @override
  Future<void> addTodo(Map<String, dynamic> todo) async {
    await _firestore.collection('todos').doc(todo['id']).set(todo);
  }

  @override
  Future<void> deleteTodo(String id) async {
    await _firestore.collection('todos').doc(id).delete();
  }

  @override
  Future<void> updateTodo(Map<String, dynamic> todo) async {
    await _firestore.collection('todos').doc(todo['id']).update(todo);
  }
}
