


import 'package:flutter/foundation.dart';
import 'package:todo/database/db.dart';
import 'package:todo/models/classes.dart';

class TaskState extends ChangeNotifier{
  var _db = DBProvider.db;
  List<Todo> _todoList = [];
  List<Task> _taskList = [];
  bool _isLoading = false;
  Map<int, int> _todoCompletionPercentage = Map();


  @override
  void addListener(listener){
    super.addListener(listener);
    //update data for every subscriber, especially for the first one
    _isLoading = true;
    loadTasksTodos();
    notifyListeners();
  }



  void loadTasksTodos() async {
    _taskList = await _db.getAllTask();
    _todoList = await _db.getAllTodo();
    _taskList.forEach((it) => _calcTaskCompletionPercent(it.id));
    _isLoading = false;
    await Future.delayed(Duration(milliseconds: 300));
    notifyListeners();
  }

  // void loadTodoList() async {
  //   _todoList = await _db.getAllTodo();
  //   _taskList.forEach((it) => _calcTaskCompletionPercent(it.id));
  //   print(_todoList);
  //   notifyListeners();
  // }

  // void loadTaskList() async {
  //   _taskList = await _db.getAllTask();
  //   print(_taskList);
  //   notifyListeners();
  // }

  @override
  void removeListener(listener) {
    super.removeListener(listener);
    print("remove listner called");
    // DBProvider.db.closeDB();
  }

  void adddTask(Task task){
    _taskList.add(task);
    _db.insertTask(task);
    notifyListeners();
  }



  void removeTask(Task task) {
    _db.removeTask(task).then((_) {
      _taskList.removeWhere((it) => it.id == task.id);
      _todoList.removeWhere((it) => it.taskId == task.id);
      notifyListeners();
    });
  }

  void updateTask(Task task) {
    var oldTask = _taskList.firstWhere((it) => it.id == task.id);
    var replaceIndex = _taskList.indexOf(oldTask);
    _taskList.replaceRange(replaceIndex, replaceIndex + 1, [task]);
    _db.updateTask(task);
    notifyListeners();
  }

  void removeTodo(Todo todo) {
    // _todoList.removeWhere((it) => it.id == todo.id);
    _todoList.remove(todo);
    _syncJob(todo);
    _db.removeTodo(todo);
    notifyListeners();
  }

  void removeTodos(Todo todo) {
    _db.removeTodo(todo).then((_) {
      //_taskList.removeWhere((it) => it.id == task.id);
      _todoList.removeWhere((it) => it.id == todo.id);
      notifyListeners();
    });
  }

  void addTodo(Todo todo) {
    _todoList.add(todo);
    _syncJob(todo);
    _db.insertTodo(todo);
    notifyListeners();
  }

  void updateTodo(Todo todo) {
    // var oldTodo = _todoList.firstWhere((it) => it.id == todo.id);
    // var replaceIndex = _todoList.indexOf(oldTodo);
    // _todoList.replaceRange(replaceIndex, replaceIndex + 1, [todo]);

    _syncJob(todo);
    _db.updateTodo(todo);

    notifyListeners();
  }


  // void updateTodos (Todo todo) async{
  //   _db.updateTodo(todo);
  //   // loadTasksTodos();
  // }

  _syncJob(Todo todo) {
    _calcTaskCompletionPercent(todo.taskId);
   // _syncTodoToDB();
  }

  void _calcTaskCompletionPercent(int taskId) {
    var todos = this._todoList.where((it) => it.taskId == taskId);
    var totalTodos = todos.length;

    if (totalTodos == 0) {
      _todoCompletionPercentage[taskId] = 0;
    } else {
      var totalCompletedTodos = todos.where((it) => it.isDone == true).length;
     _todoCompletionPercentage[taskId] = (totalCompletedTodos / totalTodos * 100).toInt();
    }
    // return todos.fold(0, (total, todo) => todo.isCompleted ? total + scoreOfTask : total);
  }


  List<Todo> get todoList => _todoList.toList();
  List<Task> get taskList => _taskList.toList();
  bool get isLoading => _isLoading;
  int getTaskCompletionPercent(Task task) => _todoCompletionPercentage[task.id];
  int getTotalTodosFrom(Task task) => todoList.where((it) => it.taskId == task.id).length;




}