class TodoModel {
  final int userId;
  final String? id;
  final String title;
  final bool completed;

  TodoModel({
    required this.userId,
    this.id,
    required this.title,
    required this.completed,
  });

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      completed: json['Completed'],
    );
  }

  Map<String, dynamic> toJson() {
    return {"userId": userId, "title": title, "Completed": false, "id": ""};
  }
}
