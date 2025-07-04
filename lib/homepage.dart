import 'package:api_test/models/todo_model.dart';
import 'package:api_test/repository/todo_repository.dart';
import 'package:flutter/material.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Homepage'), centerTitle: true),
      body: Center(
        child: Column(
          children: [
            // ElevatedButton(
            //   onPressed: () {
            //     TodoRepository.fetchAlbum();
            //   },
            //   child: Text('Get API data'),
            // ),
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
                            child: Column(
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
