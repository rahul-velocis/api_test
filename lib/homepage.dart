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
            ElevatedButton(
              onPressed: () {
                TodoRepository.fetchAlbum();
              },
              child: Text('Get API data'),
            ),
            Text('this is the homepage'),
          ],
        ),
      ),
    );
  }
}
