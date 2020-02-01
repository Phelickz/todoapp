// GENERATED CODE - DO NOT MODIFY BY HAND


part of 'task.dart';

// **************************************************************************
// BeanGenerator
// **************************************************************************

abstract class _TaskBean implements Bean<Task> {
  TodoBean get todoBean;
  final id = new IntField('id');
  final title = new StrField('title');

  Map<String, Field> _fields;
  Map<String, Field> get fields => _fields ??= {
        id.name: id,
        title.name: title,
      };
  Task fromMap(Map map) {
    Task model = new Task();

    model.id = adapter.parseValue(map['id']);
    model.title = adapter.parseValue(map['title']);


    return model;
  }

  List<SetColumn> toSetColumns(Task model,
      {bool update = false, Set<String> only}) {
    List<SetColumn> ret = [];

    if (only == null) {
      ret.add(id.set(model.id));
      ret.add(title.set(model.title));
  
    } else {
      if (only.contains(id.name)) ret.add(id.set(model.id));
      if (only.contains(title.name)) ret.add(title.set(model.title));
    
  }
    return ret;
  }

  Future<void> createTable() async {
    final st = Sql.create(tableName);
    st.addInt(id.name, primary: true, autoIncrement: true, isNullable: false);
    st.addStr(title.name, isNullable: true);
 
    return adapter.createTable(st);
  }


  Future<Task> find(int id, {bool preload: false, bool cascade: false}) async {
    final Find find = finder.where(this.id.eq(id));
    final Task model = await findOne(find);
    if (preload) {
      await this.preload(model, cascade: cascade);
    }
    return model;
  }

  // Future<List<Task>> findAll() async{
  //   Find finder = new Find(tableName);
  //   List<Map> maps = await (await _adapter.find(finder)).toList();
  //   List<Task> tasks = new List<Task>();

  //   for (Map map in maps){
  //     Task task = new Task();
  //     task.id = map['_id'];
  //     task.title = map['title'];

  //     tasks.add(task);

  //   }
  //   return tasks;
  // }

  Future<dynamic> insert(Task model, {bool cascade: false}) async {
    final Insert insert = inserter.setMany(toSetColumns(model))..id(id.name);
    final ret = await adapter.insert(insert);
    if (cascade) {
      Task newModel;
      if (model.todos != null) {
        newModel ??= await find(ret);
        model.todos.forEach((x) => todoBean.associateTask(x, newModel));
        for (final child in model.todos) {
          await todoBean.insert(child);
        }
      }
    }
    return ret;
  }

  Future<void> insertMany(List<Task> models, {bool cascade: false}) async {
    if (cascade) {
      final List<Future> futures = [];
      for (var model in models) {
        futures.add(insert(model, cascade: cascade));
      }
      return Future.wait(futures);
    } else {
      final List<List<SetColumn>> data =
          models.map((model) => toSetColumns(model)).toList();
      final InsertMany insert = inserters.addAll(data);
      return adapter.insertMany(insert);
    }
  }
  


  Future<int> update(Task model,
      {bool cascade: false, bool associate: false, Set<String> only}) async {
    final Update update = updater
        .where(this.id.eq(model.id))
        .setMany(toSetColumns(model, only: only));
    final ret = adapter.update(update);
    if (cascade) {
      Task newModel;
      if (model.todos != null) {
        if (associate) {
          newModel ??= await find(model.id);
          model.todos.forEach((x) => todoBean.associateTask(x, newModel));
        }
        for (final child in model.todos) {
          await todoBean.update(child);
        }
      }
    }
    return ret;
  }

  Future<void> updateMany(List<Task> models, {bool cascade: false}) async {
    if (cascade) {
      final List<Future> futures = [];
      for (var model in models) {
        futures.add(update(model, cascade: cascade));
      }
      return Future.wait(futures);
    } else {
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
  }


  Future<int> remove(int id, [bool cascade = false]) async {
    if (cascade) {
      final Task newModel = await find(id);
      await todoBean.removeByTask(newModel.id);
    }
    final Remove remove = remover.where(this.id.eq(id));
    return adapter.remove(remove);
  }

  Future<int> removeMany(List<Task> models) async {
    final Remove remove = remover;
    for (final model in models) {
      remove.or(this.id.eq(model.id));
    }
    return adapter.remove(remove);
  }

  Future<Task> preload(Task model, {bool cascade: false}) async {
    model.todos =
        await todoBean.findByTask(model.id, preload: cascade, cascade: cascade);
    return model;
  }

  Future<List<Task>> preloadAll(List<Task> models,
      {bool cascade: false}) async {
    models.forEach((Task model) => model.todos ??= []);
    await OneToXHelper.preloadAll<Task, Todo>(
        models,
        (Task model) => [model.id],
        todoBean.findByTaskList,
        (Todo model) => [model.taskId],
        (Task model, Todo child) => model.todos.add(child),
        cascade: cascade);
    return models;
  }

  // Future<List<Task>> findAll() async{
  //   Find finder = new Find(tableName);
  //   List<Map> maps = await (await _adapter.find(finder)).toList();
  //   List<Task> tasks = new List<Task>();

  //   for (Map map in maps){
  //     Task task = new Task();
  //     task.id = map['_id'];
  //     task.title = map['title'];

  //     tasks.add(task);

  //   }
  //   return tasks;
  // }
}