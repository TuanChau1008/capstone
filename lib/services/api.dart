import 'dart:convert';

import 'package:capstone/models/historyModel.dart';
import 'package:firebase_database/firebase_database.dart';

class Api {

  static Future<List<dynamic>> fetchHistory() async {
    final snapshot = await FirebaseDatabase.instance
        .ref()
        .child("History")
        .orderByKey()
        .get();

    List<dynamic> history = [];

    Map<dynamic, dynamic> values = snapshot.value as Map;
    history = values.values.toList();
    return history;
  }
}