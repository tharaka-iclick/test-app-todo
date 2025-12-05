import 'package:test_todo_app/modules/todo_home/domain/entities/todo.dart';

class TodoModel extends Todo {
  TodoModel({
    required String id,
    required String title,
    required String description,
    required bool isCompleted,
  }) : super(
         id: id,
         title: title,
         description: description,
         isCompleted: isCompleted,
       );

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      id: json['id'].toString(),
      title: json['title']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      isCompleted: json['isCompleted'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isCompleted': isCompleted,
    };
  }
}
