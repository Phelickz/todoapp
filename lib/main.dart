import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:todo/UI/firstscreen.dart';
// import 'package:todo/database/db.dart';
import 'package:todo/state/provider.dart';


import 'UI/homescreen.dart';
import 'models/classes.dart';

// import 'jaguar/task.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  User user;
  Task task;

  @override
  Widget build(BuildContext context) {
    //var name = DBProvider.db.getUser(1);
    
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => TaskState(),
        )
      ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: Home(task)
        ),
    );
  }
}
