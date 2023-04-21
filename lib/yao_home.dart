import 'dart:math';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Note {
  final String author;
  final String content;

  Note({required this.author, required this.content});

  factory Note.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;
    return Note(
      author: data!['author'],
      content: data['content'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'author': author,
      'content': content,
    };
  }
}

class CardColor {
  final Color backgroundColor;
  final Color titleColor;
  final Color subtitleColor;

  CardColor({
    required this.backgroundColor,
    required this.titleColor,
    required this.subtitleColor,
  });
}

class YaoHome extends StatefulWidget {
  const YaoHome({super.key});

  @override
  State<YaoHome> createState() => _YaoHomeState();
}

class _YaoHomeState extends State<YaoHome> {
  CollectionReference noteCollection =
      FirebaseFirestore.instance.collection('notes');

  final List<CardColor> cardColor = [
    CardColor(
      backgroundColor: Colors.blue,
      titleColor: Colors.white,
      subtitleColor: Colors.white,
    ),
    CardColor(
      backgroundColor: Colors.green,
      titleColor: Colors.white,
      subtitleColor: Colors.white,
    ),
    CardColor(
      backgroundColor: Colors.orange,
      titleColor: Colors.black,
      subtitleColor: Colors.black,
    ),
    CardColor(
      backgroundColor: Colors.purple,
      titleColor: Colors.white,
      subtitleColor: Colors.white,
    ),
    CardColor(
      backgroundColor: Colors.red,
      titleColor: Colors.white,
      subtitleColor: Colors.white,
    ),
  ];

  CardColor getRandomCardColor() {
    return cardColor[Random().nextInt(cardColor.length)];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Idul Fitri 1444 H'),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: noteCollection.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Note> notes = snapshot.data!.docs
                .map((doc) => Note.fromSnapshot(doc))
                .toList();
            return ListView.builder(
                itemCount: notes.length,
                shrinkWrap: true,
                primary: false,
                itemBuilder: (context, index) {
                  CardColor cardColors = getRandomCardColor();
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Card(
                      elevation: 2,
                      color: cardColors.backgroundColor,
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(8.0),
                        title: Text(
                          notes[index].author,
                          style: GoogleFonts.nunito(
                              fontSize: 24.0,
                              color: cardColors.titleColor,
                              fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          notes[index].content,
                          style: GoogleFonts.lato(
                              fontSize: 16.0,
                              color: cardColors.subtitleColor,
                              letterSpacing: 2.5,
                              height: 1.5),
                        ),
                      ),
                    ),
                  );
                });
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              String? author;
              String? content;
              return AlertDialog(
                title: const Text('say something!'),
                content: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      margin: const EdgeInsets.only(),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          hintText: 'Author',
                          labelText: 'Nama Anda',
                          labelStyle: TextStyle(
                            color: Colors.blueGrey,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.blueGrey,
                            ),
                          ),
                        ),
                        onChanged: (value) => author = value,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(12),
                      margin: const EdgeInsets.only(),
                      child: TextFormField(
                        maxLines: 10,
                        decoration: const InputDecoration(
                          labelText: 'Ucapkan kata maaf',
                          labelStyle: TextStyle(
                            color: Colors.blueGrey,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.blueGrey,
                            ),
                          ),
                        ),
                        onChanged: (value) => content = value,
                      ),
                    ),
                  ],
                ),
                actions: [
                  ElevatedButton(
                      onPressed: () async {
                        if (author != null && content != null) {
                          Note note = Note(author: author!, content: content!);
                          await noteCollection.add(note.toMap());
                          // ignore: use_build_context_synchronously
                          Navigator.of(context).pop();
                        }
                      },
                      child: const Text('Add'))
                ],
              );
            },
          );
        },
        elevation: 2,
        child: const Icon(Icons.add),
      ),
    );
  }
}
