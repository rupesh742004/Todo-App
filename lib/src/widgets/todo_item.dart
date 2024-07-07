import 'package:flutter/material.dart';

import '../model/todo_model.dart';

class TodoItem extends StatelessWidget {
  final ToDo toDo;
  final onTodochange ;
  final onTodoDelete ;



  const TodoItem({super.key, required this.toDo, this.onTodochange, this.onTodoDelete,});


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12)
      ),
      child: ListTile(
        onTap: () {
          print("Todo item clicked");
          onTodochange(toDo);
        },
        leading: Icon(
          toDo.isDone? Icons.check_box: Icons.check_box_outline_blank,
          color: Colors.blue,
        ),
        title: Text(
          toDo.todotext!,
          style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.black,
              decoration: toDo.isDone ?  TextDecoration.lineThrough : TextDecoration.none),
        ),
        trailing: Container(
          height: 35,
          width: 40,
          decoration: BoxDecoration(color: Colors.black12,
          borderRadius: BorderRadius.circular(10)),
          child: IconButton(
            color: Colors.pinkAccent,
            icon: Icon(Icons.delete),
            iconSize: 20,
            onPressed: () {
              print("Item Delete");
              onTodoDelete(toDo.id);

            },
          ),
        ),
      ),
    );
  }
}
