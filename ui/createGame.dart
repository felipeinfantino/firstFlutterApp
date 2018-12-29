import 'package:flutter/material.dart';
import 'utils.dart';
import 'setLocalHost.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CreateGame extends StatefulWidget {
  @override
  CreateGameState createState() => CreateGameState();
}

class CreateGameState extends State<CreateGame> {
  String _numberOfPlayers = null;
  String _charactersPerPerson = null;
  String _timeMin = null;
  String _timeSec = null;

  List<TextEditingController> team1 = new List();
  List<TextEditingController> team2 = new List();
  TextEditingController gameNameController = new TextEditingController();

  List<Widget> createTeam(int team) {
    int anzahl = int.parse(_numberOfPlayers);
    List<Widget> widgetsToReturn = new List();
    if (anzahl % 2 != 0) {
      //team 1 will have one more
      anzahl -= 1;
      anzahl ~/= 2;
      if (team == 1) {
        anzahl++;
      }
    } else {
      anzahl ~/= 2;
    }

    widgetsToReturn.add(new Text("Team $team"));
    for (int i = 0; i < anzahl; i++) {
      //Create Textfield
      TextEditingController tc = new TextEditingController();
      TextField t = new TextField(
        maxLines: 1,
        controller: tc,
      );
      //Add controllers
      team == 1 ? team1.add(tc) : team2.add(tc);
      widgetsToReturn.add(t);
    }
    return widgetsToReturn;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Utils.getBackgroundColor(),
      body: new ListView(
        children: <Widget>[
          new Row(
            children: <Widget>[
              new Text("Number of players : "),
              new DropdownButton<String>(
                value: _numberOfPlayers,
                items: <String>['1', '2', '3', '4', '5', '6', '7', '8']
                    .map((String value) {
                  return new DropdownMenuItem<String>(
                    value: value,
                    child: new Text(value),
                  );
                }).toList(),
                onChanged: (s) {
                  setState(() {
                    _numberOfPlayers = s;
                  });
                },
              )
            ],
          ),
          new Row(
            children: <Widget>[
              new Text("Number of characters per person : "),
              new DropdownButton<String>(
                value: _charactersPerPerson,
                items: <String>['1', '2', '3', '4', '5'].map((String value) {
                  return new DropdownMenuItem<String>(
                    value: value,
                    child: new Text(value),
                  );
                }).toList(),
                onChanged: (s) {
                  setState(() {
                    _charactersPerPerson = s;
                  });
                },
              )
            ],
          ),
          new Row(
            children: <Widget>[
              new Text("Time : "),
              new DropdownButton<String>(
                value: _timeMin,
                items: <String>['1', '2', '3', '4', '5'].map((String value) {
                  return new DropdownMenuItem<String>(
                    value: value,
                    child: new Text(value),
                  );
                }).toList(),
                onChanged: (s) {
                  setState(() {
                    _timeMin = s;
                  });
                },
              ),
              new Text("   min   "),
              new DropdownButton<String>(
                value: _timeSec,
                items: <String>['1', '2', '3', '4', '5'].map((String value) {
                  return new DropdownMenuItem<String>(
                    value: value,
                    child: new Text(value),
                  );
                }).toList(),
                onChanged: (s) {
                  setState(() {
                    _timeSec = s;
                  });
                },
              ),
              new Text("   s   ")
            ],
          ),
          new Divider(
            height: 15,
            color: Utils.getBackgroundColor(),
          ),
          _numberOfPlayers != null
              ? new Row(
                  children: <Widget>[
                    new Expanded(child: new Column(children: createTeam(1))),
                    new Padding(padding: EdgeInsets.only(right: 25)),
                    new Expanded(child: new Column(children: createTeam(2)))
                  ],
                )
              : new Container(),
          new Divider(
            height: 75,
            color: Utils.getBackgroundColor(),
          ),
          new TextField(
            controller: gameNameController,
            decoration: const InputDecoration(helperText: "Game Name"),
            style: Theme.of(context).textTheme.body1,
          ),
          new Padding(padding: EdgeInsets.only(right: 30, top: 30)),
          new Row(
            children: <Widget>[
              new Padding(padding: EdgeInsets.only(top: 30)),
              new FlatButton(
                  onPressed: () async {

                    var childObj = {};

                    var timeObj = {};
                    timeObj['min'] = int.parse(_timeMin);
                    timeObj['sec'] = int.parse(_timeSec);

                    var team1Players = {};
                    team1.forEach((f) {
                      if (f.text != '') {
                        debugPrint(f.text);
                        team1Players[f.text] = f.text;
                      }
                    });
                    var team2Players = {};
                    team2.forEach((f) {
                      if (f.text != '') {
                        debugPrint(f.text);
                        team2Players[f.text] = f.text;
                      }
                    });

                    var round1 = {};
                    round1["team1"] = 0;
                    round1["team2"] = 0;

                    var round2 = {};
                    round2["team1"] = 0;
                    round2["team2"] = 0;

                    var round3 = {};
                    round3["team1"] = 0;
                    round3["team2"] = 0;

                    //Put all in childObj and then put childObj in rootObject

                    childObj['NrPlayers'] = int.parse(_numberOfPlayers);
                    childObj['NrCharPPlayer'] = int.parse(_charactersPerPerson);
                    childObj['time'] = timeObj;
                    childObj['team1'] = team1Players;
                    childObj['team2'] = team2Players;
                    childObj['characters'] = {};
                    childObj['activePlayers'] = {};
                    childObj['round1'] = round1;
                    childObj['round2'] = round2;
                    childObj['round3'] = round3;
                    childObj['host'] = "";
                    childObj['currentTeam'] = 1;
                    childObj['currentPlayer'] = "";


                    Firestore.instance
                        .collection("games")
                        .document(gameNameController.text)
                        .setData(new Map<String, dynamic>.from(childObj));
                    Utils.setGameName(gameNameController.text);
                    Utils.setGlobalHostToThisInstance();

                    Utils.navigate(context, SetLocalHost());
                    //TODO pass to gameController, check before if empty
                  },
                  child: new Text("Create Game"))
            ],
          )
        ],
      ),
    );
  }
}
