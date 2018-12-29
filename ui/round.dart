import 'package:flutter/material.dart';
import 'utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Round extends StatefulWidget {
  @override
  RoundState createState() => RoundState();
}

class RoundState extends State<Round> {
  String round = "1";
  String currentTeam = "1";
  String currentPlayer = "felipe"; //Hole von firebase MAKE A STREAM in order to controll what is displayed !!
  String localPlayer = Utils.getLocalHost();
  int points =
      0; //Update wieder zu null beim jeden wechseln, und natürlich den document updaten

  Map<String,String> allCharacters; //hole den von firebase
  String currentCharacter  = "Tap to start"; // if in firebase the current char is "noChar" hole den ersten, else hole den indexOf diesen Char von allChars
  int currentCharacterIndex = -1;
  //Get the whole lsit, immer the current Character merken, nach jeden turn the current hcohcladem
  //Somit jedes mal in jeder runde wir holen index of und ab da starten wir ,

  //Because maybe problems with initState as async
  Future<void> _getCharachters() async {
    var documentRef = await Firestore.instance.collection("games").document(Utils.getGameName()).get();
    var chars = documentRef['characters'];
    print(chars);
    allCharacters = Map<String,String>.from(chars);
    print(allCharacters);
    currentCharacter = allCharacters["0"];
    print(currentCharacter);
  }

  @override
  void initState() {
    print("init state called");
    //Get all characters from firebase and store them in all characters
    _getCharachters();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Utils.getBackgroundColor(),
      appBar: new AppBar(
        title: new Text("Round $round , Team $currentTeam"),
        leading: new Container(),
      ),
      body: new Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          new Divider(
            height: 50,
            color: Utils.getBackgroundColor(),
          ),
          new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Center(
                child: new Text("$currentPlayer 's turn"),
              )
            ],
          ),
          new Divider(
            height: 50,
            color: Utils.getBackgroundColor(),
          ),
          localPlayer == currentPlayer
              ? new InkWell(
                  child: new Container(
                      height: 250,
                      width: 250,
                      margin: const EdgeInsets.all(15.0),
                      padding: const EdgeInsets.all(3.0),
                      decoration: new BoxDecoration(
                          border: new Border.all(color: Colors.blueAccent)),
                      child: new Center(
                        child: new Text(currentCharacter),
                      )),
                  onTap: () => setState(() {
                        currentCharacterIndex += 1;
                        if(currentCharacterIndex < allCharacters.length ){
                        currentCharacter = allCharacters["$currentCharacterIndex"];
                        }else{
                          //Round is over, update Firebase the current round and the points
                        }
                      }), //may be center
                )
              : new Container()
        ],
      ),
    );
  }
}
