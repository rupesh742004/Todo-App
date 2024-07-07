import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/src/model/todo_model.dart';
import 'package:todo/src/widgets/todo_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  static const String KEY = "TODOitemvalu";

  final todolist = ToDo.todoList();
  final _todoAddController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    CheckTodoItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
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
                      for (ToDo todoo in todolist)
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
                    margin: EdgeInsets.only(bottom: 15,left: 10,right: 5),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15)),
                    child: TextField(
                      controller: _todoAddController,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 10,),
                          prefixIconConstraints:
                              BoxConstraints(maxHeight: 20, minWidth: 25),
                          border: InputBorder.none,
                          hintText: "Add a todo item"),
                    ),
                  )),
                  Container(
                      margin: EdgeInsets.only(bottom: 15,right:10),

                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(15)),
                      child: ElevatedButton(
                        child: Icon(
                          Icons.add,
                          color: Colors.black,
                          size: 25,
                        ),
                        onPressed: () {
                          print("Add button click");
                          _addTodoItem(_todoAddController.text.toString());


                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue, elevation: 0),
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
  }

  Widget searchBox() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(15)),
      child: TextField(
        decoration: InputDecoration(
            contentPadding: EdgeInsets.all(2),
            prefixIcon: Icon(
              Icons.search,
              color: Colors.blue,
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






}

// void CheckTodoItems() async{
//
//   var sharedpref =await SharedPreferences.getInstance();
//
//   sharedpref.g
//
// }
