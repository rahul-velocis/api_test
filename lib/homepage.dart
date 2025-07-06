import 'package:api_test/form/add_todo_form.dart';
import 'package:api_test/form/edit_todo_form.dart';
import 'package:api_test/models/todo_model.dart';
import 'package:api_test/repository/todo_repository.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Homepage'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                TodoRepository.fetchAlbum();
              });
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
        child: Column(
          children: [
            FutureBuilder(
              future: TodoRepository.fetchAlbum(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final List<TodoModel> todoModelList = snapshot.data ?? [];

                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 10,
                      ),
                      child: ListView.builder(
                        itemCount: todoModelList.length,
                        itemBuilder: (context, index) {
                          final todo = todoModelList[index];
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
                                        setState(() {
                                          TodoRepository.deleteTodo(todo.id!);
                                          TodoRepository.fetchAlbum();
                                        });
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
                  );
                } else if (snapshot.hasError) {
                  return Text('has error');
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
