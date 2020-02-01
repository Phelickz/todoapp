// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo.dart';

// **************************************************************************
// BeanGenerator
// **************************************************************************

abstract class _TodoBean implements Bean<Todo> {
  final id = new IntField('id');
  final msg = new StrField('msg');
  final taskId = new IntField('task_id');
  Map<String, Field> _fields;
  Map<String, Field> get fields => _fields ??= {
        id.name: id,
        msg.name: msg,
        taskId.name: taskId,
      };
  Todo fromMap(Map map) {
    Todo model = new Todo();

    model.id = adapter.parseValue(map['id']);
    model.msg = adapter.parseValue(map['msg']);
    model.taskId = adapter.parseValue(map['post_id']);

    return model;
  }

  List<SetColumn> toSetColumns(Todo model,
      {bool update = false, Set<String> only}) {
    List<SetColumn> ret = [];

    if (only == null) {
      ret.add(id.set(model.id));
      ret.add(msg.set(model.msg));
      ret.add(taskId.set(model.taskId));
    } else {
      if (only.contains(id.name)) ret.add(id.set(model.id));
      if (only.contains(msg.name)) ret.add(msg.set(model.msg));
      if (only.contains(taskId.name)) ret.add(taskId.set(model.taskId));
    }

    return ret;
  }

  Future<void> createTable() async {
    final st = Sql.create(tableName);
    st.addInt(id.name, primary: true, isNullable: false);
    st.addStr(msg.name, isNullable: true);
    st.addInt(taskId.name,
        foreignTable: taskBean.tableName, foreignCol: 'id', isNullable: false);
    return adapter.createTable(st);
  }

  Future<dynamic> insert(Todo model) async {
    final Insert insert = inserter.setMany(toSetColumns(model));
    return adapter.insert(insert);
  }

  Future<void> insertMany(List<Todo> models) async {
    final List<List<SetColumn>> data =
        models.map((model) => toSetColumns(model)).toList();
    final InsertMany insert = inserters.addAll(data);
    return adapter.insertMany(insert);
  }

  Future<int> update(Todo model, {Set<String> only}) async {
    final Update update = updater
        .where(this.id.eq(model.id))
        .setMany(toSetColumns(model, only: only));
    return adapter.update(update);
  }

  Future<void> updateMany(List<Todo> models) async {
    final List<List<SetColumn>> data = [];
    final List<Expression> where = [];
    for (var i = 0; i < models.length; ++i) {
      var model = models[i];
      data.add(toSetColumns(model).toList());
      where.add(this.id.eq(model.id));
    }
    final UpdateMany update = updaters.addAll(data, where);
    return adapter.updateMany(update);
  }

  Future<Todo> find(int id, {bool preload: false, bool cascade: false}) async {
    final Find find = finder.where(this.id.eq(id));
    return await findOne(find);
  }

  Future<int> remove(int id) async {
    final Remove remove = remover.where(this.id.eq(id));
    return adapter.remove(remove);
  }

  Future<int> removeMany(List<Todo> models) async {
    final Remove remove = remover;
    for (final model in models) {
      remove.or(this.id.eq(model.id));
    }
    return adapter.remove(remove);
  }

  Future<List<Todo>> findByTask(int taskId,
      {bool preload: false, bool cascade: false}) async {
    final Find find = finder.where(this.taskId.eq(taskId));
    return findMany(find);
  }

  Future<List<Todo>> findByTaskList(List<Task> models,
      {bool preload: false, bool cascade: false}) async {
    final Find find = finder;
    for (Task model in models) {
      find.or(this.taskId.eq(model.id));
    }
    return findMany(find);
  }

  Future<int> removeByTask(int taskId) async {
    final Remove rm = remover.where(this.taskId.eq(taskId));
    return await adapter.remove(rm);
  }

  void associateTask(Todo child, Task parent) {
    child.taskId = parent.id;
  }

  TaskBean get taskBean;
}