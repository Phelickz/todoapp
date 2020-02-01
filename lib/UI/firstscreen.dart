import 'package:flutter/material.dart';
import 'package:todo/UI/homescreen.dart';
import 'package:todo/database/db.dart';
import 'package:todo/models/classes.dart';


class Access extends StatefulWidget {
  @override
  _AccessState createState() => _AccessState();
}

class _AccessState extends State<Access> {
  TextEditingController _textControlller = TextEditingController();

  Task task;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orangeAccent,
      body: SingleChildScrollView(
        child: Column(
          children : <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 100),
              child: Text('Define your Tasks', style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.redAccent
              ),),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 300, left: 70, right: 70),
              child: TextField(
                
                controller: _textControlller,
                decoration: InputDecoration(
                  hintText: 'Your name',
                  
                  hintStyle: TextStyle(
                    fontWeight: FontWeight.bold
                  )
                ),
                
              ),
            ),
            SizedBox(height: 10,),
            Container(
              width: 200,
              height: 50,
              child: MaterialButton(
                elevation: 10,
                
                shape: RoundedRectangleBorder(
                  
                  borderRadius: BorderRadius.circular(20)
                ),
                color: Colors.redAccent,
                onPressed: (){
                  final name = _textControlller.text;
                    DBProvider.db.insertUser(User(
                      name: name
                    ));
                    Navigator.push(context, 
            MaterialPageRoute(builder: (context) => Home(task)));
                  },
                child: Text('Get Started', style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),),
              ),
            )
          ]
        )
      ),
      
    );
  }
}