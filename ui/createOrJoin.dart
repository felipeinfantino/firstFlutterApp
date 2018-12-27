import 'package:flutter/material.dart';
import 'createGame.dart';
import 'utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'setLocalHost.dart';


class CreateOrJoin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: Utils.getBackgroundColor(),
        body: new Join()
    );
  }
}

class Join extends StatefulWidget {
  @override
  JoinState createState() => JoinState();
}

class JoinState extends State<Join> {
  bool join = false;
  bool isTextValid = false;
  TextEditingController gameName = new TextEditingController();
  String givenNameForGame = "";

  @override
  Widget build(BuildContext context) {
    return new ListView(
      children: <Widget>[
        new Row(
          children: <Widget>[
            new Divider(height: 200,),
            new Expanded(
              child: new FlatButton(
                onPressed: () => Utils.navigate(context, CreateGame()),
                child: new Text(
                  "Create",
                  style: new TextStyle(fontSize: 30),
                ),
              ),
            ),
          ],
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
        ),
        new Row(children: <Widget>[
          new Expanded(
            child: new FlatButton(
                onPressed: () => setState(() {
                      join = true;
                    }),
                child: new Text(
                  "Join",
                  style: new TextStyle(fontSize: 30),
                )),
          )
        ]),

        join
            ? new Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  new Expanded(
                    flex: 11,
                    child: new TextField(
                      controller: gameName,
                      onChanged: (text) {
                        givenNameForGame = text;
                        /*debugPrint("Aqui");
                        debugPrint(text);
                        debugPrint(isTextValid.toString());*/
                        if (text != '' && !isTextValid) {
                          isTextValid = true;
                        }
                        if (text == '' && isTextValid) {
                          isTextValid = false;
                        }
                        setState(() {});
                      },
                      maxLines: 1,
                      style: Theme.of(context).textTheme.title,
                      decoration: new InputDecoration(
                          labelText: "Name of game", isDense: true),
                    ),
                  ),
                  new Expanded(
                    flex: 1,
                    child: new IconButton(
                      color: Colors.grey[400],
                      icon: const Icon(
                        Icons.cancel,
                        size: 22.0,
                      ),
                      onPressed: () {
                        setState(() {
                          gameName.clear();
                          isTextValid = false;
                        });
                      },
                    ),
                  ),
                ],
              )
            : new Container(),
        join && isTextValid
            ? new FlatButton(
                onPressed: () async {
                  debugPrint(givenNameForGame);
                  DocumentSnapshot ds = await Utils.getGame(givenNameForGame);
                  if(ds.exists){
                    Utils.setGameName(givenNameForGame);
                    Utils.navigate(context, SetLocalHost());
                  }else{
                    //TODO snackbar
                    print("nada manino");
                  }
                },
                child: new Text(
                  "Join $givenNameForGame",
                  style: new TextStyle(fontSize: 30),
                ),
              )
            : new Container()
      ],
    );
  }
}
