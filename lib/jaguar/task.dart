import 'dart:async';


import 'package:jaguar_orm/jaguar_orm.dart';
import 'package:jaguar_query/jaguar_query.dart';



import 'todo.dart';

part 'task.jorm.dart';

// The model
class Task {
  Task();

  Task.make(this.id, this.title, this.todos);

  @PrimaryKey(auto: true)
  int id;

  @Column(isNullable: true)
  String title;

  @HasMany(TodoBean)
  List<Todo> todos;

  //@HasMany(ItemBean)
  //List<Item> items;

  String toString() =>
      'Post(id: $id, title: $title, todos: $todos)';
}

@GenBean()
class TaskBean extends Bean<Task> with _TaskBean {
  TaskBean(Adapter adapter)
      : todoBean = TodoBean(adapter),
        super(adapter);

  final TodoBean todoBean;

  // Future<int> updateReadField(int id, bool read) async {
  //   Update st = updater.where(this.id.eq(id)).set(this.read, read);
  //   return adapter.update(st);
  // }

  final String tableName = 'tasks';
}