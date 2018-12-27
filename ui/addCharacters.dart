import 'package:flutter/material.dart';
import 'utils.dart';
import 'waiting.dart';

class AddCharacters extends StatefulWidget {
  @override
  AddCharactersState createState() => AddCharactersState();
}

class AddCharactersState extends State<AddCharacters> {
  List<TextEditingController> localControllers = new List();
  bool isValid = false;

  void check() {
    isValid = true;
    localControllers.forEach((f) {
      if (f.text == '') {
        isValid = false;
      }
    });
  }

  List<Widget> createTextFields() {
    List<Widget> widgetsToReturn = new List();
    int characters = Utils.getCharactersPerPerson();
    for (int i = 0; i < characters; i++) {
      TextEditingController tc = new TextEditingController();
      TextField t = new TextField(
        maxLines: 1,
        controller: tc,
      );
      Padding p = new Padding(padding: EdgeInsets.only(bottom: 30));
      widgetsToReturn.add(p);
      widgetsToReturn.add(t);

    }
    return widgetsToReturn;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Utils.getBackgroundColor(),
      appBar: new AppBar(
        title: new Text("Enter your Characters"), leading: new Container(),
      ),
      body: new ListView(children: createTextFields()),
      floatingActionButton: new FloatingActionButton(child: new Icon(Icons.arrow_forward) ,onPressed: ()=> Utils.navigate(context, Waiting())),
    );
  }
}
