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
      floatingActionButton: selectedValue==null ? new Container() : new FloatingActionButton(child: new Icon(Icons.arrow_forward),onPressed: () async {
        if(Utils.isHost()){
          var hostObj = {};
          hostObj['host'] = selectedValue;
          var a = Map<String,dynamic>.from(hostObj);
          String b = Utils.getGameName();
          Firestore.instance
              .collection("games")
              .document(b)
              .updateData(a);

        }
        Utils.setLocalHost(selectedValue);
        Utils.navigate(context, AddCharacters());
      })
    );
  }


  List<Widget> _getData(AsyncSnapshot snapshot) {
    List<Widget> widgetsToReturn = new List();
    List<String> allPlayers = new List();
    print(snapshot.data['team1'].values);
    List<dynamic> team1Dyn = List<dynamic>.from(snapshot.data['team1'].values);
    List<String> team1 = List<String>.from(team1Dyn);
    allPlayers.addAll(team1);
    List<dynamic> team2Dyn = List<dynamic>.from(snapshot.data['team2'].values);
    List<String> team2 = List<String>.from(team2Dyn);
    allPlayers.addAll(team2);

    /*allPlayers.addAll(List<String>.from(snapshot.data['team1'].values));
    allPlayers.addAll(List<String>.from(snapshot.data['team2'].values));*/
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
