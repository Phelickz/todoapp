import 'dart:async';

import 'package:jaguar_orm/jaguar_orm.dart';
import 'package:jaguar_query/jaguar_query.dart';

import 'task.dart';

part 'todo.jorm.dart';

// The model
class Todo {
  Todo();

  Todo.make(this.id, this.msg);

  @PrimaryKey()
  int id;

  @Column(isNullable: true)
  String msg;

  @BelongsTo(TaskBean)
  int taskId;

  String toString() => 'Todo(id: $id, message: $msg)';
}

@GenBean()
class TodoBean extends Bean<Todo> with _TodoBean {
  TaskBean _taskBean;

  TaskBean get taskBean => _taskBean ??= new TaskBean(adapter);

  TodoBean(Adapter adapter) : super(adapter);

  final String tableName = 'todos';
}