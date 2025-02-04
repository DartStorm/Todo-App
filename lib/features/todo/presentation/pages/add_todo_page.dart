import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/features/todo/data/models/todo_model.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

import '../bloc/todo_bloc.dart';

class AddTodoPage extends StatefulWidget {
  const AddTodoPage({super.key});

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descController = TextEditingController();

  DateTime _selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text('Add Todo')),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  CustomTextField(
                      label: 'Title', titleController: _titleController),
                  CustomTextField(
                      minLine: 2,
                      label: 'Description',
                      titleController: _descController),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(),
                    ),
                    child: ListTile(
                      title: Text(
                        DateFormat('dd-MM-yyyy').format(_selectedDate),
                      ),
                      trailing: Icon(Icons.calendar_today),
                      onTap: () => _selectDate(context),
                    ),
                  ),
                  SizedBox(height: 30),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        fixedSize: Size(double.maxFinite, 50)),
                    onPressed: _submitForm,
                    child: Text('Save'),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final newTodo = TodoModel(
        id: Uuid().v4(),
        title: _titleController.text,
        description: _descController.text,
        isCompleted: false,
        date: _selectedDate,
      );
      context.read<TodoBloc>().add(AddTodo(newTodo));
      Navigator.pop(context);
    }
  }
}

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      required TextEditingController titleController,
      required String label,
      int? minLine})
      : _titleController = titleController,
        _minLine = minLine,
        _label = label;

  final TextEditingController _titleController;
  final String _label;
  final int? _minLine;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: TextFormField(
        controller: _titleController,
        minLines: _minLine,
        maxLines: null,
        validator: (v) => v!.isEmpty ? 'Required' : null,
        decoration: InputDecoration(
          labelText: _label, // Label for the TextField
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(), // Color when focused
            borderRadius: BorderRadius.circular(8.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),
    );
  }
}
