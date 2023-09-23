import 'package:flutter/material.dart';

import '../utils/constants/color_constant.dart';

class Notificaiton extends StatefulWidget {
  const Notificaiton({super.key});

  @override
  State<Notificaiton> createState() => _NotificaitonState();
}

class _NotificaitonState extends State<Notificaiton> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thông báo'),
        automaticallyImplyLeading: false,
        backgroundColor: ColorConstant.primaryColor,

      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Card(
          child: ListTile(
            leading: Container(
              width: 5,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.green,
              ),
            ),
            title: Text("Test Notification"),
            subtitle: Text('Task: date, title, body'),
          ),
        ),
      ),
    );
  }
}
