import 'package:flutter/material.dart';
import 'utils.dart';
import 'gameOver.dart';
import 'round.dart';
class Waiting extends StatefulWidget{
  @override
  WaitingState createState() => WaitingState();
  
}

class WaitingState extends State<Waiting>{
  @override
  Widget build(BuildContext context) {
    //TODO in createGame set a new variable in firebase, waitingForplayers and a list of players, then every time
    // a player add characters, delete himself from that firebase variable
    return new Scaffold(
      backgroundColor: Utils.getBackgroundColor(),
      appBar: new AppBar(title: new Text("Waiting for other Players"),leading: new Container(),),
      body: new InkWell(
        child: new Center(
           child : new Text("Tap To continue")
        ),
        onTap: () => Utils.navigate(context, Round()),
      ),
    );
  }
  
  
}