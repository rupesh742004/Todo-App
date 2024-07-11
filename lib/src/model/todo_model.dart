import 'package:todo/src/model/sharedprif.dart';

class ToDo {
  String? id;
  String? todotext;
  bool isDone;

  ToDo({
    required this.id,
    required this.todotext,
    this.isDone = false,
  });

  factory ToDo.fromJson(Map<String, dynamic> json) {
    return ToDo(
      id: json['id'],
      todotext: json['todotext'],
      isDone: json['isDone'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'todotext': todotext,
      'isDone': isDone,
    };
  }

  static Future<List<ToDo>> todoList() async {
    List<ToDo> todos = await loadToDoList();
    return todos;
  }
}
