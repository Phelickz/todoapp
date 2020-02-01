import 'package:flutter/widgets.dart';
import 'package:jaguar_query_sqflite/jaguar_query_sqflite.dart';
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';

import 'todo.dart';
import 'task.dart';


// class DB{
//   static SqfliteAdapter _adapter;

//   DB._();
//   static final DB db = DB._();
//   var sb = StringBuffer();
//   final bean = TaskBean(_adapter);
//   final todoBean = TodoBean(_adapter);

//   Future<SqfliteAdapter> get adapter async {
//     if (_adapter != null) return _adapter;

//     _adapter = await initDB();
//     return _adapter;
//   }

//   initDB() async {
//     await Sqflite.setDebugModeOn(true);
   
//     sb.writeln("Jaguar ORM showcase:");

//     sb.writeln('--------------');
//     sb.write('Connecting ...');
//     var dbPath = await getDatabasesPath();
//     _adapter = SqfliteAdapter(path.join(dbPath, "test.db"));

//     await _adapter.connect();
//     sb.writeln(' successful!');
//     sb.writeln('--------------');

    

//     await bean.drop();
//     await todoBean.drop();

//     sb.write('Creating table ...');
//     await bean.createTable();
//     await todoBean.createTable();
//     sb.writeln(' successful!');
//     sb.writeln('--------------');

//     sb.writeln('Inserting sample rows ...');
//     var task = new Task.make(null, 'Coffee?',
//         [new Todo.make(1, 'test'), new Todo.make(2, 'test 2')]);
//     int id1 = await bean.insert(task, cascade: true);
//     sb.writeln(
//         'Inserted successfully row with id: $id1 and one to many relation!');

//     sb.writeln('--------------');
//   }

//   Future<List<Task>> getAllTask() async{
//     sb.writeln('Reading all rows ...');
//     List<Task> tasks = await bean.getAll();
//     tasks.forEach((p) => sb.writeln(p));
//     sb.writeln('--------------');
//   }

// }


SqfliteAdapter _adapter;

void main() async {
  await Sqflite.setDebugModeOn(true);
  var sb = StringBuffer();
  sb.writeln("Jaguar ORM showcase:");

  sb.writeln('--------------');
  sb.write('Connecting ...');
  var dbPath = await getDatabasesPath();
  _adapter = SqfliteAdapter(path.join(dbPath, "test.db"));

  try {
    await _adapter.connect();
    sb.writeln(' successful!');
    sb.writeln('--------------');

    final bean = TaskBean(_adapter);
    final todoBean = TodoBean(_adapter);

    await bean.drop();
    await todoBean.drop();

    sb.write('Creating table ...');
    await bean.createTable();
    await todoBean.createTable();
    sb.writeln(' successful!');
    sb.writeln('--------------');

    // Delete all
    sb.write('Removing old rows (if any) ...');
    await bean.removeAll();
    sb.writeln(' successful!');
    sb.writeln('--------------');

    // Insert some tasks
    sb.writeln('Inserting sample rows ...');
    var task = new Task.make(null, 'Coffee?',
        [new Todo.make(1, 'test'), new Todo.make(2, 'test 2')]);
    int id1 = await bean.insert(task, cascade: true);
    sb.writeln(
        'Inserted successfully row with id: $id1 and one to many relation!');

    sb.writeln('--------------');

    // Find one task
    sb.writeln('Reading row with id $id1 with one to one relation...');
    Task task1 = await bean.find(id1, preload: true);
    sb.writeln(task1);
    sb.writeln('--------------');

    // Find all tasks
    sb.writeln('Reading all rows ...');
    List<Task> tasks = await bean.getAll();
    tasks.forEach((p) => sb.writeln(p));
    sb.writeln('--------------');

    // // Update a task
    // sb.write('Updating a column in row with id $id1 ...');
    // await bean.updateReadField(id1, true);
    // sb.writeln(' successful!');
    // sb.writeln('--------------');

    // Find one task
    sb.writeln('Reading row with $id1 to check the update ...');
    task1 = await bean.find(id1);
    sb.writeln(task1);
    sb.writeln('--------------');

    sb.writeln('Removing row with id $id1 ...');
    await bean.remove(id1);
    sb.writeln('--------------');

    // Find all tasks
    sb.writeln('Reading all rows ...');
    tasks = await bean.getAll();
    tasks.forEach((p) => sb.writeln(p));
    sb.writeln('--------------');

    sb.writeln('Removing all rows ...');
    await bean.removeAll();
    sb.writeln('--------------');

    sb.write('Closing the connection ...');
    await _adapter.close();
    sb.writeln(' successful!');
    sb.writeln('--------------');
  } finally {
    print(sb.toString());
  }

  runApp(SingleChildScrollView(
      child: Text(sb.toString(), textDirection: TextDirection.ltr)));
}