import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/UI/addtask.dart';
import 'package:todo/UI/taskscreen.dart';
// import 'package:todo/jaguar/dbb.dart';
// import 'package:todo/jaguar/task.dart';
import 'package:todo/models/classes.dart';
import 'package:intl/intl.dart';
import 'package:todo/state/provider.dart';
import 'package:todo/widgets/task_progress_indicator.dart';






class Home extends StatefulWidget {
  
  final Task task;
  Home(this.task);
  
  @override
  _HomeState createState() => _HomeState(this.task);
}

class _HomeState extends State<Home> {
 // List<Todo> _todos = [];
 // var _db = DBProvider.db;
 // List<Todo> get todos => _todos.toList();
 //int getTaskCompletionPercent(Task task) => _taskCompletionPercentage[task.id];

  // void load() async {
  //  _todos = await _db.getAllTodo();
  // }
  // Map<int, int> _taskCompletionPercentage =  Map();
//  static SqfliteAdapter _adapter;
//  final bean = TaskBean(_adapter);
  final Task task;
  User user;
  _HomeState(this.task);
 static var date = DateTime.now();
  var datee = DateFormat('EEEE, d MMM').format(date);
  @override
  Widget build(BuildContext context) {
  
    var state = Provider.of<TaskState>(context);
    var _tasks = state.taskList;

    
    
    //var name = DBProvider.db.getUser();
    return SafeArea(
          child: Scaffold(
        backgroundColor: Colors.pink[900],
        appBar: AppBar(
          title: Text('TODO',),
          centerTitle: true,
         // leading: IconButton(icon: Icon(Icons.line_style,), onPressed: (){},),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.search), onPressed: (){},)

          ],
          elevation: 0.0,
          backgroundColor: Colors.pink[900],
        ),
        drawer: Container(
          height: double.maxFinite,
          // decoration: BoxDecoration(
          //   borderRadius: BorderRadius.circular(20)
          // ),
          child: Drawer(
            
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  margin: EdgeInsets.zero,
                  padding: EdgeInsets.zero,
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        bottom: 12.0,
                        left: 16.0,
                        child: Text(
                          "Categories", style: TextStyle(
                            color: Colors.white54,
                            fontSize: 30,
                            fontWeight: FontWeight.bold
                          )
                        ),
                      ),
                      
                    ],
                  ),
                  decoration: BoxDecoration(
                    color: Colors.pink[900],
                  ),
                  
                ),
                Container(
                  height: double.maxFinite,
                  child: ListView.builder(
                    
                    itemBuilder: (BuildContext context, int index){
                      var tasks = _tasks[index];
                      return Container(
                        child: ListTile(
                          onTap: (){
                            Navigator.push(context,
                            MaterialPageRoute(builder: (context) => TaskScreen(_tasks[index].id)));
                            },
                          title: Text(tasks.title, 
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500
                            ),)

                        ),
                      );
                    },
                    itemCount: _tasks.length,
                  ),
                )
                
              ],
              
            ),
            
          ),
        ),
        body: Consumer<TaskState>(
          builder: (context, taskState, child) {
            var _tasks = taskState.taskList;
            var _todos = taskState.todoList;
            return SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 50, top: 10),
                  height: 150,
                  child:Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        //SizedBox(height: 20,),
                        Row(
                          children: <Widget>[
                            Flexible(
                              child: IconButton(icon: Icon(Icons.account_circle), 
                            onPressed: (){},
                            iconSize: 40,),
                          ),]
                        ),
                        SizedBox(height: 10,),
                        Text('Hello', 
                        style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          
                          color: Colors.white),),
                          SizedBox(height: 20,),
                        Text('You have ${_todos.where((todo) => todo.isDone == false).length} uncompleted tasks today', style: TextStyle(
                          color: Colors.white60,
                          fontSize: 15
                        ),),
                        
                        //Text('Date would be here', style: TextStyle(color: Colors.white))
                      ]
                      ), 
                  ),
                  SizedBox(height: 10,),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 50, ),
                          child: Text(datee,
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                            fontWeight: FontWeight.bold
                          ),),
                        ),
                        // FutureBuilder(
                        //   future: DBProvider.db.getAllTask(),
                        //   builder: (BuildContext context, AsyncSnapshot<List<Task>> snapshot) {
                        //    if (snapshot.hasData){
                        //      if (snapshot.data.isEmpty){
                               
                        //        return GestureDetector(
                        //          onTap: (){
                        //           Navigator.push(context, 
                        //           MaterialPageRoute(builder: (context) => AddTask(TaskMode.Adding, task)));
                        //           },
                        //           child: Container(
                        //            height: 350,
                                   
                        //            margin: EdgeInsets.only(top:20,
                        //            left: 50, right: 50),
                                   
                        //            decoration: BoxDecoration(
                                     
                        //              color: Colors.white,
                        //              borderRadius: BorderRadius.circular(20)
                        //            ),
                        //            child: Center(
                        //              child: IconButton(
                        //                icon: Icon(Icons.add),
                        //                color: Colors.black45,
                        //                iconSize: 80,
                        //                onPressed: (){
                        //                 Navigator.push(context, 
                        //                 MaterialPageRoute(builder: (context) => AddTask(TaskMode.Editing, task)));
                        //               },
                        //              ),
                        //            ),
                        //          ),
                        //        );
                        //      }
                         // for (Task task in taskState.taskList)
                             Container(
                               height: 400,
                             //  color: Colors.blue,
                               margin: EdgeInsets.only(top: 50,  
                                ),
                               child: ListView.builder(
                                 
                                controller: ScrollController(),
                                scrollDirection: Axis.horizontal,
                                 itemBuilder: (BuildContext context, int index){
                                  // Task item = snapshot.data[index];
                                   return Container(
                                     margin: EdgeInsets.only(left: 20,
                                     bottom: 50),
                                     width: 300,
                                       height: 300,
                                       
                                       child: GestureDetector(
                                         onTap: (){
                                           Navigator.push(context,
                                           MaterialPageRoute(builder: (context) => TaskScreen(_tasks[index].id)));
                                         },
                                         child: Card(
                                          elevation: 10,
                                           shape: RoundedRectangleBorder(
                                             borderRadius: BorderRadius.circular(30)
                                           ),
                                           color: Colors.white,
                                           margin: EdgeInsets.only(
                                             right: 12, left: 12, 
                                             bottom: 12, top: 3),
                                            child: SingleChildScrollView(
                                                child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children : <Widget>[
                                                    Padding(
                                                      padding: const EdgeInsets.only(top: 20, left: 20),
                                                      child: Icon(Icons.call_to_action, color: Colors.pink[900],) ,
                                                          ),
                                                    IconButton(icon: Icon(Icons.delete, color: Colors.pink[900]), 
                                                    onPressed: (){
                                                      state.removeTask(_tasks[index]);
                                                      Navigator.pushAndRemoveUntil(context, 
                                                        MaterialPageRoute(
                                                          builder: (context) => Home(task)), 
                                                         (Route<dynamic> route) => false);
                                                    },)   
                                                          ]
                                                  ),
                                                    
                                                    
                                                  
                                                  SingleChildScrollView(
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: <Widget>[

                                                     
                                                  
                                                  SizedBox(height: 190,),
                                                  Padding(
                                                    padding: const EdgeInsets.only(left:20),
                                                    child: Text('${taskState.getTotalTodosFrom(_tasks[index])} Tasks',
                                                    style: TextStyle(
                                                      //fontSize: 30,
                                                      //fontWeight: FontWeight.bold,
                                                      color: Colors.black45
                                                    ),),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.only(left:20),
                                                    child: Text(_tasks[index].title,
                                                    style: TextStyle(
                                                      fontSize: 30,
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.grey
                                                    ),),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.all(15.0),
                                                    child: TaskProgressIndicator(
                                                      progress: taskState.getTaskCompletionPercent(_tasks[index]),

                                                    )
                                                    // child: new LinearPercentIndicator(
                                                    //   width: 230.0,
                                                    //   lineHeight: 18.0,
                                                    //   percent: calcTaskCompletionPercent(item.id),
                                                    //   center: Text(
                                                    //     "80.0%",
                                                    //     style: new TextStyle(fontSize: 12.0),
                                                    //   ),
                                                     
                                                    //   linearStrokeCap: LinearStrokeCap.roundAll,
                                                    //   backgroundColor: Colors.grey,
                                                    //   progressColor: Colors.green,
                                                    // ),
                                                //  ),
                                                  
                                                  )],
                                                    )
                                                    )
                                                ],
                                              ),
                                            )
                                         ),
                                       ),
                                     );
                                   
                                 },
                                 itemCount: _tasks.length 
                               ),
                             )
                        //    }return Center(child: CircularProgressIndicator(),);
                        //  },
                        // )
                      ],
                    )
                  )

              ]
              ),
          );
          }
        ),
          floatingActionButton: FloatingActionButton.extended(
            
            label: Text('New',
            style: TextStyle(color: Colors.black,
            fontWeight: FontWeight.bold),),
            icon: Icon(Icons.add, color: Colors.black,),
            backgroundColor: Colors.pink[900],
            onPressed: (){
            Navigator.push(context, 
            MaterialPageRoute(builder: (context) => AddTask(TaskMode.Adding, task)));
          },
          ),
      ),
    );
      
    
  }

    // calcTaskCompletionPercent(int taskId) {
    // var todos = this.todos.where((it) => it.taskId == taskId);
    // var totalTodos = todos.length;

    // if (totalTodos == 0) {
    //   _taskCompletionPercentage[taskId] = 0;
    // } else {
    //   var totalCompletedTodos = todos.where((it) => it.isDone == true).length;
    //  _taskCompletionPercentage[taskId] = (totalCompletedTodos / totalTodos * 100).toInt();
    // }
    // // return todos.fold(0, (total, todo) => todo.isCompleted ? total + scoreOfTask : total);
//  }

}


// class Date extends StatefulWidget {
//   @override
//   _DateState createState() => _DateState();
// }

// class _DateState extends State<Date> {
//   var date = DateTime.now();

//   @override
//   Widget build(BuildContext context) {
//     return Text(
      
//     );
//   }
// }