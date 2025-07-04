import 'package:api_test/models/todo_model.dart';
import 'package:api_test/repository/todo_repository.dart';
import 'package:flutter/material.dart';

class AddTodoForm extends StatefulWidget {
  const AddTodoForm({super.key});

  @override
  State<AddTodoForm> createState() => _AddTodoFormState();
}

class _AddTodoFormState extends State<AddTodoForm> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _userIdController = TextEditingController();
  bool isCompleted = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add Todo'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 20,
        children: [
          TextFormField(
            controller: _titleController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              label: Text('Title'),
            ),
          ),
          TextFormField(
            controller: _userIdController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              label: Text('UserId'),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Is Completed:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              Switch(
                value: isCompleted,
                activeColor: Colors.blue,
                onChanged: (bool value) {
                  setState(() {
                    isCompleted = value;
                  });
                },
              ),
            ],
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            if (_titleController.text.isNotEmpty &&
                _userIdController.text.isNotEmpty &&
                int.tryParse(_userIdController.text) != null) {
              final todo = TodoModel(
                userId: int.parse(_userIdController.text),
                title: _titleController.text.trim(),
                completed: isCompleted,
              );

              TodoRepository.postTodo(todo);
            }
            Navigator.of(context).pop();
          },
          child: Text('Add'),
        ),
      ],
    );
  }
}
