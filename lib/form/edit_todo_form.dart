import 'package:api_test/models/todo_model.dart';
import 'package:api_test/provider/todo_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditTodoForm extends StatefulWidget {
  final TodoModel todo;
  const EditTodoForm({super.key, required this.todo});

  @override
  State<EditTodoForm> createState() => _EditTodoFormState();
}

class _EditTodoFormState extends State<EditTodoForm> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _userIdController = TextEditingController();
  bool isCompleted = false;

  @override
  void initState() {
    _titleController.text = widget.todo.title;
    _userIdController.text = widget.todo.userId.toString();
    isCompleted = widget.todo.completed;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Edit Todo'),
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
                id: widget.todo.id, // id remain the same
                userId: int.parse(_userIdController.text),
                title: _titleController.text.trim(),
                completed: isCompleted,
              );

              context.read<TodoProvider>().editTodo(todo);
            }
            Navigator.of(context).pop();
          },
          child: Text('Edit'),
        ),
      ],
    );
  }
}
