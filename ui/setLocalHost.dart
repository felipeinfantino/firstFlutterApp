import 'package:flutter/material.dart';
import 'utils.dart';
import 'addCharacters.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SetLocalHost extends StatefulWidget {
  @override
  SetLocalHostState createState() => SetLocalHostState();
}

class SetLocalHostState extends State<SetLocalHost> {
  String selectedValue ;

  void changeValue(String newValue) {
    setState(() {
      selectedValue = newValue;
    });
  }

  Future<List<Widget>> createRadioButtonsInRows() async {

  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text("Who are you?"),leading: new Container()),
      backgroundColor: Utils.getBackgroundColor(),
      body: new FutureBuilder(
          future: Firestore.instance.collection("games").document(Utils.getGameName()).get(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!=null) {
                return new Column (
                  children: <Widget>[
                    new Expanded(
                        child: new ListView(
                          children: _getData(snapshot),
                        ))
                  ],
                );
              } else {
                return new CircularProgressIndicator();
              }
            }else{
              return new Text("Loading...");
            }
          }
      ),
      floatingActionButton: selectedValue==null ? new Container() : new FloatingActionButton(child: new Icon(Icons.arrow_forward),onPressed: () {
        if(Utils.isHost()){
          Utils.setGlobalHost(selectedValue);
        }
        Utils.setLocalHost(selectedValue);
        Utils.navigate(context, AddCharacters());
      })
    );
  }


  List<Widget> _getData(AsyncSnapshot snapshot) {

    List<Widget> widgetsToReturn = new List();
    List<String> allPlayers = new List();
    allPlayers.addAll(List<String>.from(snapshot.data['team1']));
    allPlayers.addAll(List<String>.from(snapshot.data['team2']));
    for (String i in allPlayers) {
      Row row = new Row(
        children: <Widget>[
          new Radio(
              value: i,
              groupValue: selectedValue,
              onChanged: (s) => changeValue(s)),
          new Text(i)
        ],
      );
      widgetsToReturn.add(row);
    }
    return widgetsToReturn;
  }
}
