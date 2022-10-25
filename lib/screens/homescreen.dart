// ignore_for_file: prefer_const_constructors, sort_child_properties_last, use_key_in_widget_constructors, avoid_print, duplicate_ignore, unused_local_variable

import 'package:flutter/material.dart';
import '../components/event_card.dart';
import '../models/event.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class HomeScreen extends StatelessWidget {
  List<Event> events = [
    Event(name: "name", location: "place1", StartDateTime: DateTime.now()),
    Event(name: "name1", location: "place11", StartDateTime: DateTime.now()),
    Event(name: "name2", location: "place12", StartDateTime: DateTime.now()),
    Event(name: "name3", location: "place13", StartDateTime: DateTime.now()),
    Event(name: "name4", location: "place14", StartDateTime: DateTime.now()),
];

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("JVT"),
        centerTitle: true,
        backgroundColor: Colors.grey,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('items').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if(!snapshot.hasData) Text("У вас нет записей", style: TextStyle(color: Colors.purpleAccent),);
          return ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: snapshot.data!.docs.length,
            padding: EdgeInsets.all(50),
            itemBuilder: (BuildContext context, index) {
              return Dismissible(key: UniqueKey(),
                child: Card(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  shadowColor: Colors.purpleAccent,
                  color: Colors.purpleAccent,
                  child: ListTile(
                    title: Text(snapshot.data!.docs[index
                    ].get('item'), style: TextStyle(color: Colors.white, fontSize: 25),),
                    subtitle: Column(children: [
                      SizedBox(
                        height: 20,
                      ),
                      Text("Create time - ${snapshot.data!.docs[index].get('nowtime')}", style: TextStyle(color: Colors.purple,))
                    ],),
                    leading: Icon(
                      Icons.add_chart_sharp,
                      color: Colors.purple,
                      size: 40,
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete_forever),
                      color: Colors.purple,
                      onPressed: () {
                        FirebaseFirestore.instance.collection('items').doc(snapshot.data!.docs[index].id).delete();
                      },
                    ),
                    // ignore: avoid_print
                    onTap: () => print("onTap"),
                    onLongPress: () => print("OnLongPress"),
                  ),
                ),
                onDismissed: (direction) {
                  FirebaseFirestore.instance.collection('items').doc(snapshot.data!.docs[index].id).delete();
                },
              );
            }
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add, size: 40),
        backgroundColor: Colors.purple,
        onPressed: () => showDialog(context: context, builder: (BuildContext context) {
          var userToDo;
          return AlertDialog(
              title: Text("Добавить элемент"),
              content: TextField(
                onChanged: (String value) {
                  userToDo = value;
                },
              ),
              actions: [
                ElevatedButton(onPressed: () {
                  FirebaseFirestore.instance.collection('items').add({'item': userToDo, 'nowtime': DateTime.now().toString()});
                    }, child: Text("Добавить"))
              ],
            );
          },)
      ),
      backgroundColor: Colors.white,
    );
  }
}