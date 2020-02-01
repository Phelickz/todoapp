import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/UI/homescreen.dart';
import 'package:todo/models/classes.dart';
import 'package:todo/state/provider.dart';
import 'package:todo/widgets/task_progress_indicator.dart';

import 'addtodo.dart';


class TaskScreen extends StatefulWidget {
 //  final taskId;
  // final HeroId heroIds;
  final int taskId;
   TaskScreen(
     this.taskId,
      );
  //   @required this.heroIds
  // });
  // final Task task;

 // TaskScreen(this.task);


  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
  }

   Task task;
  @override
  Widget build(BuildContext context) {
    Task _task;

    
    _controller.forward();
    var state = Provider.of<TaskState>(context);
    _task = state.taskList.firstWhere((it) => it.id == widget.taskId);
    var _todos = state.todoList.where((it) => it.taskId == widget.taskId).toList();
   //var todos = state.todoList.firstWhere((it) => it.taskId == widget.taskId);

    // var _hero = widget.heroIds;
    // Task _task;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.grey,),
          onPressed: (){
            Navigator.pop(context);
          },
          
        ),
        actions: <Widget>[
          // IconButton(
          //   icon: Icon(Icons.edit, color: Colors.redAccent,),
          //   onPressed: (){
          //   Navigator.push(context, 
          //   MaterialPageRoute(builder: (context) => AddTask(TaskMode.Editing, widget.task.id)));
          // },
          // ),
          IconButton(
            icon: Icon(Icons.delete, color: Colors.redAccent,),
            onPressed: (){
              state.removeTask(_task);
              Navigator.pushAndRemoveUntil(context, 
                                MaterialPageRoute(
                                  builder: (context) => Home(task)), 
                                  (Route<dynamic> route) => false);
            },
          ),
          

        ],
        elevation: 0,
        backgroundColor: Colors.white,
      ),
       body: Container(
              padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 8.0),
              child: Column(children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 36.0, vertical: 0.0),
                  height: 160,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(Icons.call_to_action, color: Colors.redAccent,),
                      Spacer(
                        flex: 1,
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 4.0),
                        child: Text('${state.getTotalTodosFrom(_task)} Task', style: TextStyle(color: Colors.black26),),
                      ),
                      Container(
                        child: Text(_task.title,
                         style: TextStyle(
                           fontSize: 30,
                           fontWeight: FontWeight.bold,
                           color: Colors.black54
                         ),),
                      ),
                      Spacer(),
                      TaskProgressIndicator(progress: state.getTaskCompletionPercent(_task),),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(top: 16.0),
                    // child: FutureBuilder(
                    //   future: DBProvider.db.findByTask(widget.task.id),
                    //   builder: (BuildContext context, AsyncSnapshot<List<Todo>> snapshot){
                    //     if (snapshot.hasData){
                        child: ListView.builder(
                        itemBuilder: (BuildContext context, int index) {
                          // Todo list = snapshot.data[index];
                          var todo = _todos[index];
                          return Container(
                            padding: EdgeInsets.only(left: 22.0, right: 22.0),
                             child: ListTile(
                            // onTap: () => state.updateTodo(todo.copy(
                            //     isDone: todo.isDone == true ? false : true)),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 0, vertical: 8.0),
                            leading: Checkbox(
                              
                                activeColor: Colors.pink[900],
                                onChanged: (value) {setState(() {
                                    todo.isDone = value;
                                });
                                state.updateTodo(todo.copy(isDone: value == true? false: true));},
                                value: todo.isDone == true ? true : false),
                            trailing: IconButton(
                              icon: Icon(Icons.delete_outline),
                              onPressed: () {state.removeTodo(todo);}
                            ),
                            title: Text(
                              todo.description,
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w600,
                                color: todo.isDone == true
                                    ? Colors.pink[900]
                                    : Colors.black54,
                                decoration: todo.isDone == true
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                              ),
                            ),
                          ),
                          );
                        },
                        itemCount: _todos.length
                      )
                    //   }return CircularProgressIndicator();
                    //   }
                    // ),
                  ),
                ),
              ]),
            ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text('New Tasks',
          style: TextStyle(
            fontWeight: FontWeight.bold
          ),),
        icon: Icon(Icons.add),
        backgroundColor: Colors.redAccent,
        onPressed: (){
            Navigator.push(context, 
            MaterialPageRoute(builder: (context) => AddTodoScreen(taskId: widget.taskId, todoMode: TodoMode.Adding,)));
          },

      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

}