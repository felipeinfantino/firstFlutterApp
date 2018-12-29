import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Utils {

  static List<String> _charachters = new List();

  static bool _host = false;

  static String _gameName;

  static String _globalHost;

  static String _localhost;

  static navigate(BuildContext context, obj){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => obj),
    );
  }

  static Future<DocumentSnapshot> getGame(String gameName){
    return Firestore.instance.collection("games").document(gameName).get();
  }

  static setGlobalHostToThisInstance(){
    _host = true;
  }


  static isHost(){
    return _host;
  }

  static Color getBackgroundColor(){
    return Colors.amber;
}

  static List<String> mockPlayers(){
    return ["player 1", "player2", "playe3"];
  }

  static setGameName(String gameName){
    _gameName = gameName;
  }

  static String getGameName(){
    return _gameName;
  }

  static Future<List<String>> getPlayers()  {
    //Mischung aus team1 + team2
   return Firestore.instance.collection("games").document(_gameName).get().then((doc) {
     List<String> allPlayers = new List();
     allPlayers.addAll(List<String>.from(doc.data['team1']));
     allPlayers.addAll(List<String>.from(doc.data['team2']));
     return allPlayers;
   });
  }

  //TODO add synchronized , two persons adding at same time will crash
  static void addCharacter(String character){
    _charachters.add(character);
  }

  static int getCharactersPerPerson(){
    return 3;
  }

  static void setLocalHost(String localhost) {
    _localhost = localhost;
  }

  static String getLocalHost(){
    return _localhost;
  }
}