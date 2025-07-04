import 'dart:convert';
import 'dart:developer';

import 'package:api_test/models/todo_model.dart';
import 'package:http/http.dart' as http;

class TodoRepository {
  static Future<List<TodoModel>?> fetchAlbum() async {
    final String url =
        'https://6866622d89803950dbb27925.mockapi.io/ap1/v1/GroceryItems';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final dataList = jsonDecode(response.body) as List<dynamic>?;

        final todoModelList =
            dataList?.map((e) => TodoModel.fromJson(e)).toList() ?? [];

        return todoModelList;
      }

      return [];
    } catch (e) {
      log("Error ${e.toString()}");
    }
  }

  static Future<void> deleteTodo(String todoItemId) async {
    final String url =
        'https://6866622d89803950dbb27925.mockapi.io/ap1/v1/GroceryItems/$todoItemId';

    try {
      final response = await http.delete(Uri.parse(url));

      if (response.statusCode == 200) {
        log(response.body);

        // final todoModelList =
        //     dataList?.map((e) => TodoModel.fromJson(e)).toList() ?? [];

        // return todoModelList;
      }
    } catch (e) {
      log("Error ${e.toString()}");
    }
  }
}
