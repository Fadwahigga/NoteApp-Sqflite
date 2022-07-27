// ignore_for_file: must_be_immutable, avoid_unnecessary_containers, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:sqflite_noteapp/editnotes.dart';
import 'package:sqflite_noteapp/sqdb.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  SqlDb sqlDb = SqlDb();

  bool isloading = true;

  List notes = [];

  Future readData() async {
    List<Map> response = await sqlDb.readData("SELECT * FROM notes");
    notes.addAll(response);
    isloading = false;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    readData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed("addnotes");
        },
        child: const Icon(Icons.add),
      ),
      body: Container(
        child: ListView(
          children: [
            /*
            MaterialButton(
              onPressed: () async {
                await sqlDb.mydeletedatabase();
              },
              child: const Text("delete database"),
            ),
            */
            ListView.builder(
                itemCount: notes.length,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: ((context, i) {
                  return Card(
                      child: ListTile(
                    title: Text("${notes[i]['note']}"),
                    subtitle: Text("${notes[i]['title']}"),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                            onPressed: () async {
                              int response = await sqlDb.deleteData(
                                  "DELETE FROM 'notes' WHERE id = ${notes[i]['id']} ");
                              if (response > 0) {
                                notes.removeWhere((element) =>
                                    element['id'] == notes[i]['id']);
                                setState(() {});
                              }
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            )),
                        IconButton(
                            onPressed: () async {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => EditNotes(
                                          note: notes[i]['note'],
                                          title: notes[i]['title'],
                                          color: notes[i]['color'],
                                          id: notes[i]['id'],
                                        )),
                              );
                            },
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.blue,
                            ))
                      ],
                    ),
                  ));
                }))
          ],
        ),
      ),
    );
  }
}
