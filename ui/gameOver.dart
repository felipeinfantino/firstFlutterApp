import 'package:flutter/material.dart';
import 'utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GameOver extends StatelessWidget {
  Widget create(List<DocumentSnapshot> lista) {
    List<Widget> widgetsList = new List();

    for (DocumentSnapshot i in lista) {
      if (i.data['arrayTest'] != null) {
        for (String p in i.data['arrayTest']) {
          widgetsList.add(new Text(p));
        }
      }
    }

    return new Column(children: widgetsList);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: Utils.getBackgroundColor(),
        appBar:
            new AppBar(title: new Text("Game Over"), leading: new Container()),
        body: new StreamBuilder(
            stream: Firestore.instance.collection("test").snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return new Text("Loading");
              return create(snapshot.data.documents);
            }));
  }
}
