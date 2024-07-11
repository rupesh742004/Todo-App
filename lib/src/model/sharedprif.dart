import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'package:todo/src/model/todo_model.dart';

// static const String todoKey = 'todoItems';

Future<List<ToDo>> loadToDoList() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String> encodedList = prefs.getStringList('todoList') ?? [];
  return encodedList
      .map((encodedTodo) => ToDo.fromJson(jsonDecode(encodedTodo)))
      .toList();
}

Future<void> saveToDoList(List<ToDo> todoList) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String> encodedList =
      todoList.map((todo) => jsonEncode(todo.toJson())).toList();
  await prefs.setStringList('todoList', encodedList);
}
