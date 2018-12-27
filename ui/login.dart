import 'package:flutter/material.dart';
import 'package:first_app/ui/createOrJoin.dart';
import './utils.dart';
class Login extends StatelessWidget{



  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Utils.getBackgroundColor(),
      body: new InkWell(
        child: new Center(
          child: new Text("Login, tap to continue", style: new TextStyle(color: Colors.red),),
        ),
        onTap: () => Utils.navigate(context, CreateOrJoin()) ,
      ),
    );
  }



}