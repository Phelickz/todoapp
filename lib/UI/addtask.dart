

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/models/classes.dart';
import 'package:todo/state/provider.dart';

import 'homescreen.dart';



enum TaskMode{
  Editing,
  Adding
}


class AddTask extends StatefulWidget {

  final Task task;
  final TaskMode taskMode;

  AddTask(this.taskMode, this.task);

// final Task task;

// AddTask(this.task);

  @override
  _AddTaskState createState() => _AddTaskState(this.taskMode);
}

class _AddTaskState extends State<AddTask> {
  final TaskMode taskMode;
  Task task;

  _AddTaskState(this.taskMode);

  final TextEditingController _titleController = TextEditingController();


  @override
  void didChangeDependencies(){
    if(widget.taskMode == TaskMode.Editing){
     _titleController.text = widget.task.title;
      super.didChangeDependencies();
  }}

  @override
  Widget build(BuildContext context) {

      var _state = Provider.of<TaskState>(context);
    // var _task = _state.taskList.firstWhere((it) => it.id == widget.taskId);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back),
        color: Colors.black,
        onPressed: (){
          Navigator.pop(context);
        },),
        backgroundColor: Colors.white,
        title: Text(taskMode == TaskMode.Adding ? 'New Category' : 'Edit Category',
        style: TextStyle(
          color: Colors.black,
        ),),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Column(
        children: <Widget>[
          SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.only(left: 40, top: 20),
            child: Text('Category will help you define your tasks', 
            style: TextStyle(fontSize: 17,color: Colors.grey),),
          ),
          SizedBox(height: 30,),
          Divider(thickness: 0.3,),
          Flexible(
              child: Padding(
                padding: const EdgeInsets.only(left: 20, top: 20),
                child: TextField(
                controller: _titleController,
                decoration: InputDecoration.collapsed(
                  hintText: 'Category Name....',
                  
                  hintStyle: TextStyle(fontSize: 30, color: Colors.grey)
                ),
                maxLines: 30,
            ),
              ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: MaterialButton(
              
              height: 50,
              color: Colors.orangeAccent,
              
              onPressed: (){
                if (widget?.taskMode == TaskMode.Adding){
                final title = _titleController.text;
                _state.adddTask(
                  Task(
                    
                    title: title
                  )
                );
                print('Task saved');
                Navigator.pushAndRemoveUntil(context, 
                                MaterialPageRoute(
                                  builder: (context) => Home(task)), 
                                  (Route<dynamic> route) => false);
              }
              else{
                final title = _titleController.text;
                _state.updateTask(
                  Task(
                    id: widget.task.id,
                    title : title
                  )
                );
              }},
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                
              ),
              child: Text(taskMode == TaskMode.Adding? 'Create New Category': 'Save Edited Category',
              style: TextStyle(fontWeight: FontWeight.bold))
              
            ),
          )
        ],
      ),
      
    );
  }
}