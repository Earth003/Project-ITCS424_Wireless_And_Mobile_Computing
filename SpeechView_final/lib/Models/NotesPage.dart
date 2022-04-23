import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'dart:convert';

import 'package:path_provider/path_provider.dart';

List<String> noteDescription = [];
List<String> noteHeading = [];
TextEditingController noteHeadingController = new TextEditingController();
TextEditingController noteDescriptionController = new TextEditingController();
FocusNode textSecondFocusNode = new FocusNode();

int notesHeaderMaxLenth = 25;
int notesDescriptionMaxLines = 10;
int notesDescriptionMaxLenth;
String deletedNoteHeading = "";
String deletedNoteDescription = "";

Future<String> get _localPath async {
  // final directory = await getApplicationDocumentsDirectory();
  // For your reference print the AppDoc directory
  final directory = 'D:\\Flutter files\\Week5 clone github\\ITCS-424\\labs\\5-week\\Project_Wireless\\SpeechView';
  //print(directory.path);
  return directory;
}

Future<File> get _localFile async {
  final path = await _localPath;
  return File('$path\\speechview_data.txt');
}

Future writeContent() async {
  try {
    final file = await _localFile;
    // Write the file
    var sink = file.openWrite();
    for (int i=0; i<noteHeading.length;i++){
      sink.write(noteHeading[i]+'\n'+noteDescription[i]+'\n');
    }
    sink.close();
  } catch (e) {
    print('Error: $e');
  }
}

Future readcontent() async {
  try {
    int  lineIndex = 0;
    final file = await _localFile;
    Stream<String> lines = file.openRead().transform(utf8.decoder).transform(LineSplitter()); // Decode bytes to UTF-8. // Convert stream to individual lines.

    await for (var line in lines) {
      if (lineIndex%2 == 0) {
        noteHeading.add(line);
      } else {
        noteDescription.add(line);
      }
      lineIndex += 1;
    }
  } catch (e) {
    print('Error: $e');
  }
}

List<Color> noteColor = [
  Colors.pink[50],
  Colors.green[50],
  Colors.blue[50],
  Colors.orange[50],
  Colors.indigo[50],
  Colors.red[50],
  Colors.yellow[50],
  Colors.brown[50],
  Colors.teal[50],
  Colors.purple[50],
];
List<Color> noteMarginColor = [
  Colors.pink[300],
  Colors.green[300],
  Colors.blue[300],
  Colors.orange[300],
  Colors.indigo[300],
  Colors.red[300],
  Colors.yellow[300],
  Colors.brown[300],
  Colors.teal[300],
  Colors.purple[300],
];
