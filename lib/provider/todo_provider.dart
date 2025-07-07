import 'package:api_test/models/todo_model.dart';
import 'package:api_test/repository/todo_repository.dart';
import 'package:flutter/material.dart';

class TodoProvider extends ChangeNotifier {
  List<TodoModel> _todos = [];

  List<TodoModel> get todos => _todos;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void getTodos() async {
    _isLoading = true;
    notifyListeners();

    final newTodo = await TodoRepository.fetchAlbum();

    _todos = newTodo;

    _isLoading = false;
    notifyListeners();
  }

  void createTodo(TodoModel todo) async {
    _isLoading = true;
    notifyListeners();

    await TodoRepository.createTodo(todo);

    final newTodo = await TodoRepository.fetchAlbum();

    _todos = newTodo;

    _isLoading = false;
    notifyListeners();
  }

  void deleteTodo(String id) async {
    _isLoading = true;
    notifyListeners();

    await TodoRepository.deleteTodo(id);


    final newTodo = await TodoRepository.fetchAlbum();

    _todos = newTodo;

    _isLoading = false;
    notifyListeners();
  }

  void editTodo(TodoModel todo) async {
    _isLoading = true;
    notifyListeners();

    await TodoRepository.editTodo(todo);

    final newTodo = await TodoRepository.fetchAlbum();

    _todos = newTodo;

    _isLoading = false;
    notifyListeners();
  }
}
