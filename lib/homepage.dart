import 'package:api_test/form/add_todo_form.dart';
import 'package:api_test/form/edit_todo_form.dart';
import 'package:api_test/provider/todo_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  void initState() {
    context.read<TodoProvider>().getTodos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final todoProvider = context.read<TodoProvider>();
    final todos = context.watch<TodoProvider>().todos;
    final isLoading = context.watch<TodoProvider>().isLoading;
    return Scaffold(
      appBar: AppBar(
        title: Text('Homepage'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              todoProvider.getTodos();
            },
            icon: Icon(Icons.refresh),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          showDialog(context: context, builder: (context) => AddTodoForm());
        },
      ),
      body: Center(
        child: isLoading
            ? CircularProgressIndicator()
            : Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 10,
                      ),
                      child: ListView.builder(
                        itemCount: todos.length,
                        itemBuilder: (context, index) {
                          final todo = todos[index];
                          return Container(
                            padding: EdgeInsets.all(20),
                            margin: EdgeInsets.only(bottom: 20),
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(20),
                            ),
                            // height: 100,
                            child: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Title: ${todo.title}',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      'UserId: ${todo.userId}',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      'isCompleted: ${todo.completed}',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                Spacer(),
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: () async {
                                        showDialog(
                                          context: context,
                                          builder: (context) =>
                                              EditTodoForm(todo: todo),
                                        );
                                      },
                                      icon: Icon(
                                        Icons.edit_outlined,
                                        color: Colors.blue,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        todoProvider.deleteTodo(todo.id ?? '');
                                      },
                                      icon: Icon(
                                        Icons.delete_outline,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
