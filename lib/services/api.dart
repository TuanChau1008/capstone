import 'dart:convert';

import 'package:capstone/models/historyModel.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../main.dart';




class Api {
  static final _firebaseMessaging = FirebaseMessaging.instance;

  static Future<void> initNotification() async {
    await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    await Firebase.initializeApp();
    final fCMToken = await _firebaseMessaging.getToken();

    print('Token123: $fCMToken');

    initPushNotification();
  }

  static void handleMessage(RemoteMessage? message) async{
    if(message == null) return;

    navigatorKey.currentState?.pushNamed(
      '/notification_screen/notificaiton_screen'
    );
  }

  static Future initPushNotification() async{
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);

    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      final notification = message.notification;
      if (notification != null) {
        print('Notification Title: ${notification.title}');
        print('Notification Body: ${notification.body}');
      }
    });
    //FirebaseMessaging.onBackgroundMessage(handleMessage as BackgroundMessageHandler);
  }

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

  static Future<List<dynamic>> fetchNotify() async {
    final snapshot = await FirebaseDatabase.instance
        .ref()
        .child("Notification")
        .child("-Nfq5eFxO6t4najckyZe")
        .child("message")
        .orderByKey()
        .get();

    List<dynamic> notify = [];

    Map<dynamic, dynamic> values = snapshot.value as Map;
    notify = values.values.toList();
    return notify;
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