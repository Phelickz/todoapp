


class Task{
  final int id;
  final String title;
  List<Todo> todos;
 // Todo tasks;
  
  Task({this.id, this.title});



  factory Task.fromMap(Map<String, dynamic> data) {
  return Task(
    id : data['id'],
    title: data['title'],
  );
}

Map<String, dynamic> toMap() => {
      'id': this.id,
      'title': this.title,
    };

}

// class Tasks{
//   int id;
//   String title;

//   Tasks(this.id, this.title);
// }





// class Todo{
//   final int id;
//   List options;
//   bool completed = false;

//   Todo({this.id, this.options, this.completed = false});
// }

class Todo {
  int id;
  int taskId;
  //description is the text we see on
  //main screen card text
  String description;
  Task task;
  //isDone used to mark what Todo item is completed
  bool isDone = false;  //When using curly braces { } we note dart that
  //the parameters are optional
  Todo({this.id, this.description, this.isDone = false, this.taskId});


  factory Todo.fromMap(Map<String, dynamic> data) => Todo(
    //This will be used to convert JSON objects that
    //are coming from querying the database and converting
    //it into a Todo object        id: data['id'],
        description: data['description'],  
            //Since sqlite doesn't have boolean type for true/false
        //we will 0 to denote that it is false
        //and 1 for true
        isDone: data['isDone'] == 0 ? false : true,
       taskId: data['taskId']
      
      );  
  Map<String, dynamic> toMap() => {
    //This will be used to convert Todo objects that
    //are to be stored into the datbase in a form of JSON        "id": this.id,
        "description": this.description,
        "isDone": this.isDone == false ? 0 : 1,
        "taskId": this.taskId
      };

  Todo copy({String description, bool isDone, int id, int taskId}) {
    return Todo(
      description: description ?? this.description,
      isDone: isDone ?? this.isDone,
      id: id ?? this.id,
     taskId: taskId ?? this.taskId
    );
  }

  @override
    String toString() {
      return 'Todo{id: $id, description: $description, taskId: $taskId, isDone: $isDone}';
    }
}


class User{
  int id;
  String name;

  User({this.id, this.name});


    factory User.fromMap(Map<String, dynamic> data) => User(
    //This will be used to convert JSON objects that
    //are coming from querying the database and converting
    //it into a Todo object        id: data['id'],
        name: data['name'],  
      );  
  Map<String, dynamic> toMap() => {
    //This will be used to convert Todo objects that
    //are to be stored into the datbase in a form of JSON        "id": this.id,
        "name": this.name,
      };


}