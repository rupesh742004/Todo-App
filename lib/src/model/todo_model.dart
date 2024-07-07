class ToDo {
  String? id;
  String? todotext;
  bool isDone;

  ToDo({
    required this.id,
    required this.todotext,
    this.isDone = false,
  });

  static List<ToDo> todoList(){
    return [
      // ToDo(id: "01", todotext: "todotext" ,isDone: true),
      // ToDo(id: "02", todotext: "todotext" ,isDone: true),
      // ToDo(id: "03", todotext: "todotext" ,),

    ];
  }
}
