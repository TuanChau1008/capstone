import 'package:capstone/history_screen/detail.dart';
import 'package:flutter/material.dart';

import '../utils/constants/color_constant.dart';

class History extends StatefulWidget {
  const History({Key? key}) : super(key: key);

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lịch sử hòm thư'),
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
                          title: Text("data.dateTime.toString()"),
                          subtitle: Text('Task:'),
                          trailing: TextButton(
                            onPressed: () {
                              if (context.mounted) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        HistoryDetail(
                                          // bookingId: "bookingId",
                                          // boxId: boxId,
                                          // cabinetName: cabinetName,
                                          // // boxName: boxName,
                                          // status: status,
                                          // validDate: validDate,
                                          // onCancel: () {
                                          //   setState(() {});
                                          // },
                                        ),
                                  ),
                                );
                              }
                            },
                            child: const Text("Chi tiết"),
                          ),
                        ),
                      ),
        ),
      );
  }
}