import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ToDo App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ToDoScreen(),
    );
  }
}

class ToDoScreen extends StatefulWidget {
  @override
  _ToDoScreenState createState() => _ToDoScreenState();
}

class _ToDoScreenState extends State<ToDoScreen> {
  List<String> _todoItems = [];

  @override
  void initState() {
    super.initState();
    _loadToDoItems();
  }

  // Load ToDo items from SharedPreferences
  void _loadToDoItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _todoItems = (prefs.getStringList('todoItems') ?? []);
    });
  }

  // Save ToDo items to SharedPreferences
  void _saveToDoItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('todoItems', _todoItems);
  }

  void _addToDoItem(String task) {
    if (task.isNotEmpty) {
      setState(() {
        _todoItems.add(task);
      });
      _saveToDoItems();
    }
  }

  void _removeToDoItem(int index) {
    setState(() {
      _todoItems.removeAt(index);
    });
    _saveToDoItems();
  }

  Widget _buildToDoItem(String task, int index) {
    return ListTile(
      title: Text(task),
      trailing: IconButton(
        icon: Icon(Icons.delete),
        onPressed: () => _removeToDoItem(index),
      ),
    );
  }

  void _promptAddToDoItem() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add a new task'),
          content: TextField(
            autofocus: true,
            onSubmitted: (val) {
              Navigator.of(context).pop();
              _addToDoItem(val);
            },
          ),
          actions: [
            ElevatedButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ToDo App'),
      ),
      body: ListView.builder(
        itemCount: _todoItems.length,
        itemBuilder: (context, index) {
          return _buildToDoItem(_todoItems[index], index);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _promptAddToDoItem,
        tooltip: 'Add task',
        child: Icon(Icons.add),
      ),
    );
  }
}
