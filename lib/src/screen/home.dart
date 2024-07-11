import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/src/model/todo_model.dart';
import 'package:todo/src/widgets/todo_item.dart';

import '../model/sharedprif.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ToDo> todolist = [];
  final _todoAddController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadToDoList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: buildAppBar(),
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  searchBox(),
                  Expanded(
                      child: ListView(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 20, bottom: 20),
                        child: Text(
                          " All Todos",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),
                      for (ToDo todoo in todolist.reversed)
                        TodoItem(
                          toDo: todoo,
                          onTodochange: _todoChange,
                          onTodoDelete: _todoDelete,
                        )
                    ],
                  ))
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                children: [
                  Expanded(
                      child: Container(
                    margin: EdgeInsets.only(bottom: 15, left: 10, right: 5),
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(100, 149, 237, 100),
                        borderRadius: BorderRadius.circular(15)),
                    child: TextField(
                      controller: _todoAddController,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(
                            left: 20,
                          ),
                          prefixIconConstraints:
                              BoxConstraints(maxHeight: 20, minWidth: 25),
                          border: InputBorder.none,
                          hintText: "Add a todo item"),
                    ),
                  )),
                  Container(
                      margin: EdgeInsets.only(bottom: 15, right: 10),
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(0, 150, 255, 100),
                          borderRadius: BorderRadius.circular(15)),
                      child: ElevatedButton(
                        child: Icon(
                          Icons.add,
                          color: Colors.black,
                          size: 25,
                        ),
                        onPressed: () async {
                          print("Add button click");
                          _addTodoItem(_todoAddController.text.toString());
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromRGBO(100, 149, 237, 0),
                            elevation: 0),
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _addTodoItem(String todo) {
    setState(() {
      todolist
          .add(ToDo(id: DateTime.now().microsecond.toString(), todotext: todo));
    });
    _todoAddController.clear();
    _saveToDoList();
  }

  void _todoChange(ToDo toDo) {
    setState(() {
      toDo.isDone = !toDo.isDone;
    });
  }

  void _todoDelete(String id) {
    setState(() {
      todolist.removeWhere((element) => element.id == id);
    });
    _saveToDoList();
  }

  Widget searchBox() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
          color: Color.fromRGBO(100, 149, 237, 100),
          borderRadius: BorderRadius.circular(15)),
      child: TextField(
        decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.search,
              color: Colors.black87,
              size: 20,
            ),
            prefixIconConstraints: BoxConstraints(maxHeight: 20, minWidth: 25),
            border: InputBorder.none,
            hintText: "search"),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.blueAccent,
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(Icons.menu_sharp),
          Icon(Icons.supervised_user_circle_outlined),
        ],
      ),
    );
  }

  Future<void> _loadToDoList() async {
    List<ToDo> todos = await loadToDoList();
    setState(() {
      todolist = todos;
    });
  }

  Future<void> _saveToDoList() async {
    List<String> encodedList =
        todolist.map((todo) => jsonEncode(todo.toJson())).toList();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('todoList', encodedList);
  }
}
