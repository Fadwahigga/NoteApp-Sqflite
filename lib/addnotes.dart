// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:sqflite_noteapp/home.dart';
import 'package:sqflite_noteapp/sqdb.dart';

class AddNotes extends StatefulWidget {
  const AddNotes({Key? key}) : super(key: key);

  @override
  State<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
  SqlDb sqlDb = SqlDb();
  GlobalKey<FormState> formstate = GlobalKey();
  TextEditingController note = TextEditingController();
  TextEditingController title = TextEditingController();
  TextEditingController color = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Notes"),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            Form(
                key: formstate,
                child: Column(
                  children: [
                    TextFormField(
                      controller: note,
                      decoration: const InputDecoration(hintText: "Note"),
                    ),
                    TextFormField(
                      controller: title,
                      decoration: const InputDecoration(hintText: "Title"),
                    ),
                    TextFormField(
                      controller: color,
                      decoration: const InputDecoration(hintText: "Color"),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    MaterialButton(
                      color: Colors.blue,
                      textColor: Colors.white,
                      onPressed: () async {
                        int response = await sqlDb.insertData('''
                                INSERT INTO notes (note , title , color)
                                VALUES ("${note.text}" , "${title.text}" , "${color.text}")
                                            ''');
                        if (response > 0) {
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(builder: (context) => Home()),
                              (route) => false);
                        }
                        print("response===============");
                        print(response);
                      },
                      child: const Text(
                        "Add Notes",
                        style: TextStyle(fontSize: 30),
                      ),
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
