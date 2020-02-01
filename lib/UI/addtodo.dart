

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/models/classes.dart';
import 'package:todo/state/provider.dart';


enum TodoMode{
  Editing,
  Adding
}

class AddTodoScreen extends StatefulWidget {
  final int taskId;
  final TodoMode todoMode;
  // final Task task;

  AddTodoScreen({@required this.taskId, this.todoMode});
  @override
  _AddTodoScreenState createState() => _AddTodoScreenState(this.todoMode);
}

class _AddTodoScreenState extends State<AddTodoScreen> {
  final TodoMode todoMode;
  // Task task;
  String newTask;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  _AddTodoScreenState(this.todoMode);

  // @override
  // void didChangeDependencies(){
  //   if(widget.todoMode == TodoMode.Editing){
  //    newTask = widget.task.title;
  //     super.didChangeDependencies();
  // }}

  @override
  void initState(){
    super.initState();
    setState(() {
      newTask = '';
    });
  }

  @override
  Widget build(BuildContext context) {

    var _state = Provider.of<TaskState>(context);
    var _task = _state.taskList.firstWhere((it) => it.id == widget.taskId);

    // Task task;
    // var task = widget.taskId;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
         todoMode == TodoMode.Adding ? 'New Task' : 'Edit Task',
          style: TextStyle(color: Colors.black),
            ),
        centerTitle: true,
        elevation: 0,
       iconTheme: IconThemeData(color: Colors.black26),
        brightness: Brightness.light,
        backgroundColor: Colors.white,
          ),
      body: Container(
            constraints: BoxConstraints.expand(),
            padding: EdgeInsets.symmetric(horizontal: 36.0, vertical: 36.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'What task are you planning to perform?',
                  style: TextStyle(
                      color: Colors.black38,
                      fontWeight: FontWeight.w600,
                      fontSize: 16.0),
                ),
                Container(
                  height: 16.0,
                ),
                TextField(
                  onChanged: (text) {
                    setState(() => newTask = text);
                  },
                  cursorColor: Colors.redAccent,
                  autofocus: true,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Your Task...',
                      hintStyle: TextStyle(
                        color: Colors.black26,
                      )),
                  style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.w500,
                      fontSize: 36.0),
                ),
                Container(
                  height: 26.0,
                ),
              ]
              )
              ),
      floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: Builder(
            builder: (BuildContext context) {
              return FloatingActionButton.extended(
                heroTag: 'fab_new_task',
                icon: Icon(Icons.add),
                backgroundColor: Colors.redAccent,
                label: Text(todoMode == TodoMode.Adding ? 'Create new Task' : 'Save Edited Task'),
                onPressed: () {
                  if (newTask.isEmpty) {
                    final snackBar = SnackBar(
                      content: Text(
                          'Ummm... It seems that you are trying to add an invisible task which is not allowed in this realm.'),
                      backgroundColor: Colors.redAccent
                    );
                    Scaffold.of(context).showSnackBar(snackBar);
                    // _scaffoldKey.currentState.showSnackBar(snackBar);
                  } else {
                    if (widget?.todoMode == TodoMode.Adding){
                      _state.addTodo(Todo(
                    taskId: _task.id,
                    description: newTask
                    ));
                    Navigator.pop(context);
                  }else{
                    _state.updateTodo(Todo(description: newTask, taskId:_task.id));
                  }}
                },
              );
            }));
  }
}


