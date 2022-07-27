// ignore_for_file: avoid_print, use_build_context_synchronously, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:sqflite_noteapp/home.dart';
import 'package:sqflite_noteapp/sqdb.dart';

class EditNotes extends StatefulWidget {
  final note;
  final title;
  final color;
  final id;
  const EditNotes({Key? key, this.note, this.title, this.color, this.id})
      : super(key: key);

  @override
  State<EditNotes> createState() => _EditNotesState();
}

class _EditNotesState extends State<EditNotes> {
  SqlDb sqlDb = SqlDb();

  GlobalKey<FormState> formstate = GlobalKey();
  TextEditingController note = TextEditingController();
  TextEditingController title = TextEditingController();
  TextEditingController color = TextEditingController();

  @override
  void initState() {
    note.text = widget.note;
    title.text = widget.title;
    color.text = widget.color;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Notes"),
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
                        int response = await sqlDb.updateData(''' 
                        UPDATE notes SET note = "${note.text}" , 
                        title = "${title.text}" , 
                        color = "${color.text}" 
                        WHERE id = ${widget.id}
                         ''');
                        if (response > 0) {
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(builder: (context) => Home()),
                              (route) => false);
                        }
                      },
                      child: const Text("Edit Notes",
                          style: TextStyle(fontSize: 30)),
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
