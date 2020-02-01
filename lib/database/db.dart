

import 'package:path/path.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo/models/classes.dart';

class DBProvider {
  static Database _database;

  DBProvider._();
  static final DBProvider db = DBProvider._();

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await initDB();
    return _database;
  }

 

  initDB() async {
  
    var path = await getDatabasesPath();
    var dbPath = join(path, 'duties.db');

    return await openDatabase(
      dbPath, version: 1, onOpen: (db) {

    }, onCreate: (Database db, int version) async {
      print("DBProvider:: onCreate()");
      await db.execute("CREATE TABLE Class ("
          "id INTEGER PRIMARY KEY,"
          "title TEXT"
          ")");
      await db.execute("CREATE TABLE duties ("
          "id INTEGER PRIMARY KEY,"
          "description TEXT,"
          "isDone INTEGER NOT NULL DEFAULT 0,"
          "taskId INTEGER ,"
          "FOREIGN KEY (taskId) REFERENCES Class (id) ON UPDATE CASCADE ON DELETE CASCADE"
          ")");
      await db.execute("CREATE TABLE Users ("
          "id INTEGER PRIMARY KEY,"
          "name TEXT"
          ")");
          
    });
  }

  insertBulkTask(List<Task> tasks) async {
    final db = await database;
    tasks.forEach((it) async {
      var res = await db.insert("Class", it.toMap());
      print("Class ${it.id} = $res");
    });
  }

  insertBulkTodo(List<Todo> todos) async {
    final db = await database;
    todos.forEach((it) async {
      var res = await db.insert("duties", it.toMap());
      print("duties ${it.id} = $res");
    });
  }

  Future<List<Task>> getAllTask() async {
    final db = await database;
    var result = await db.query('Class');
    print(result);
    return result.map((it) => Task.fromMap(it)).toList();
  }

  Future<List<Todo>> getAllTodo() async {
    final db = await database;
    var result = await db.query('duties');
    print(result);
    return result.map((it) => Todo.fromMap(it)).toList();
  }

  Future<List<Todo>> findByTask(int taskId) async{
    final db = await database;
    var result = await db.query('duties', where: 'taskId = ?', whereArgs: [taskId]);
    return result.map((it) => Todo.fromMap(it)).toList();
  }

  // Future<User> getUser() async {
  //   final db = await database;
  //   var result = await db.query('Users');
  //   print(result);
  //   return result.first;
  // }

  getUser() async{
    final db = await database;
    var res = await db.query('Users', where: 'id = ?',);
    return res.isNotEmpty ? User.fromMap(res.first) : Null;
  }

  Future<int> updateTodo(Todo todo,) async {
    final db = await database;
    return db
        .update('duties', todo.toMap(), where: 'id = ?', whereArgs: [todo.id]);
  }

  Future<int> removeTodo(Todo todo) async {
    final db = await database;
    return db.delete('duties', where: 'id = ?', whereArgs: [todo.id]);
  }

  // Future<int> deleteTodo(int id) async {
  //   final db = await database;
  //   var result = await db.delete('duties', where: 'id = ?', whereArgs: [id]);
  //   return result;
  // }

  Future<int> insertTodo(Todo todo) async {
    final db = await database;
    return db.insert('duties', todo.toMap());
  }

  Future<int> insertTask(Task task) async {
    final db = await database;
    print(task.id);
    return db.insert('Class', task.toMap());
    
  }

  Future<int> insertUser(User user) async {
    final db = await database;
    print(user.id);
    return db.insert('Users', user.toMap());
    
  }


  Future<void> deleteTask(int id) async {
      // Get a reference to the database.
      final db = await database;

      // Remove the Dog from the database.
      await db.delete(
        'Class',
        // Use a `where` clause to delete a specific dog.
        where: "id = ?",
        // Pass the Dog's id as a whereArg to prevent SQL injection.
        whereArgs: [id],
      );
    }

  Future<void> removeTask(Task task) async {
    final db = await database;
    return db.transaction<void>((txn) async {
      await txn.delete('duties', where: 'taskId = ?', whereArgs: [task.id]);
      await txn.delete('Class', where: 'id = ?', whereArgs: [task.id]);
    });
  }

  Future<int> updateTask(Task task) async {
    final db = await database;
    return db
        .update('Class', task.toMap(), where: 'id = ?', whereArgs: [task.id]);
  }

  // Future<String> get _localPath async {
  //   final directory = await getApplicationDocumentsDirectory();
  //   return directory.path;
  // }


  closeDB() {
    if (_database != null) {
      _database.close();
    }
  }
}
