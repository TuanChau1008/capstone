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

  static Future<String> fetchMasterCode() async {
    final snapshot = await FirebaseDatabase.instance
        .ref()
        .child("Cabinet")
        .child("-Nf5Hul8WlIoPX4H0xNB")
        .child("masterCode")
        .get();

    return snapshot.value.toString();
  }

  static Future<String> fetchStatus() async {
    final snapshot = await FirebaseDatabase.instance
        .ref()
        .child("QRCode")
        .child("0849953007")
        .child("status")
        .get();

    return snapshot.value.toString();
  }
  static Future<List<dynamic>> fetchMailBoxLog() async {
    final snapshot = await FirebaseDatabase.instance
        .ref()
        .child("MailBoxLog")
        .limitToLast(1)
        .get();


    List<dynamic> result = [];

    Map<dynamic, dynamic> values = snapshot.value as Map;
    result = values.values.toList();

    return result;
  }

  static void changeMasterCode(String masterCode) async {
    DatabaseReference changMasterCode= FirebaseDatabase.instance
        .ref()
        .child("BookingOrder")
        .child("-Ni8Zv8DYrsm3bMZ7eB2");

    DatabaseReference changCode= FirebaseDatabase.instance
        .ref()
        .child("Cabinet")
        .child("-Nf5Hul8WlIoPX4H0xNB");

    Map<String, dynamic> code1 =
    {
        "addDate": "2023-09-24T01:26:02.1015935-07:00",
        "businessId": "-Nf5H_45gvDvWJlfVSHi",
        "id": "-Nf5Hul8WlIoPX4H0xNB",
        "locationId": "-Nf5HnV0o8mZWBpk3R-T",
        "masterCode": masterCode,
        "masterCodeStatus": 1,
        "nameCabinet": "Mailbox",
        "status": 1,
        "totalBox": 1
    };

    Map<String, dynamic> code =
    {
      "boxId": "-Nf5IIoTMOQ1XuN8qf_7",
      "businessId": "-Nf5H_45gvDvWJlfVSHi",
      "createDate": "2023-10-18 16:27",
      "deviceId": "87bb999684cccb39",
      "id": "-Ni8Zv8DYrsm3bMZ7eB2",
      "status": "3",
      "unlockCode": masterCode,
      "validDate": "2023-11-01 18:40:39"
    };
    changMasterCode.update(code);
    changCode.update(code1);


  }

  static Future<bool> register(String name, String password, String phone, String email) async {
    bool status = true;
    DatabaseReference register = FirebaseDatabase.instance
        .ref()
        .child('Customer')
        .child(phone);
    Map<String, dynamic> customer =
    {
      "FullName": name,
      "Password": password,
      "Phone": phone,
      "Email": email
    };
    register.update(customer);
    print(status);
    return status;
  }
}