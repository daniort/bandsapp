import 'dart:io';

import 'package:bandapp/models/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final textController = new TextEditingController();
  List<Band> bands = [
    Band(id: '1', name: 'Metallica', votes: 5),
    Band(id: '2', name: 'Rammstein', votes: 6),
    Band(id: '3', name: 'Simple Plan', votes: 2),
    Band(id: '4', name: 'LinkinPark', votes: 7),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('BandsName', style: TextStyle(color: Colors.grey[900])),
          backgroundColor: Colors.grey[200],
          elevation: 1.0,
          centerTitle: true,
          actions: [
            Icon(Icons.warning),
          ],
        ),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add), elevation: 1.0, onPressed: addNewBand),
        body: ListView.builder(
          itemCount: bands.length,
          itemBuilder: (context, i) => _bandTile(bands[i]),
        ));
  }

  Widget _bandTile(Band band) {
    return Dismissible(
      key: Key(band.id),
      direction: DismissDirection.startToEnd,
      onDismissed: (direction){
        //Eliminar
        print( direction );
        print( band.id );
      },
      background: Container(
        padding: EdgeInsets.all(5),
        color: Colors.pink[900],
        child: Align(
            alignment: Alignment.centerLeft,
            child: Icon(Icons.delete, color: Colors.white)),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.deepPurple[300],
          child: Text(band.name.substring(0, 2),
              style: TextStyle(color: Colors.white)),
        ),
        title: Text(band.name),
        trailing: Text(
          band.votes.toString(),
          style: TextStyle(fontSize: 18),
        ),
        onTap: () {
          print(band.name);
        },
      ),
    );
  }

  addNewBand() {
    if (Platform.isAndroid)
      return showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Add Band'),
          content: TextField(controller: textController),
          actions: [
            MaterialButton(
              child: Text('Add', style: TextStyle(color: Colors.deepPurple)),
              elevation: 5,
              onPressed: () => saveNewBand(textController.text),
            ),
          ],
        ),
      );
    else
      return showCupertinoDialog(
        context: context,
        builder: (_) => CupertinoAlertDialog(
          title: Text('add'),
          content: CupertinoTextField(
            controller: textController,
          ),
          actions: [
            CupertinoDialogAction(
              isDefaultAction: true,
              child: Text('Add'),
              onPressed: () => saveNewBand(textController.text),
            ),
            CupertinoDialogAction(
              isDestructiveAction: true,
              child: Text('Dismiss'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      );
  }

  saveNewBand(String text) {
    if (text.length > 1) {
      this
          .bands
          .add(new Band(id: DateTime.now().toString(), name: text, votes: 0));
      textController.clear();
    }
    Navigator.pop(context);
  }
}
