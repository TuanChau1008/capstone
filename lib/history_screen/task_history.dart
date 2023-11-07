import 'package:capstone/history_screen/detail.dart';
import 'package:capstone/services/api.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../utils/constants/color_constant.dart';

class History extends StatefulWidget {
  const History({Key? key}) : super(key: key);

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  final DatabaseReference _database = FirebaseDatabase.instance.ref();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lịch sử hòm thư'),
        automaticallyImplyLeading: false,
        backgroundColor: ColorConstant.primaryColor,
      ),
      body: RefreshIndicator(
        onRefresh: () {
          return Future(() {
            setState(() {});
          });
        },
        child: FutureBuilder(
          future: Api.fetchHistory(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return const Center(child: CircularProgressIndicator());
              case ConnectionState.done:
                  return Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            //String boxId = snapshot.data![index]['BoxId'];
                            String cabinetName =
                            snapshot.data![index]["BoxName"].toString();
                            // String boxName = snapshot.data![index]['BoxName'];
                            String validDate =
                            snapshot.data![index]['EndDate'];
                            String status = "";
                            if (snapshot.data![index]['Status'].toString() == '4') {
                              status = "Hoàn thành";
                            } else if (snapshot.data![index]['Status'].toString() == '5') {
                              status = "Đã Hủy";
                            }
                            return SizedBox(
                              height: size.height * 0.10,
                              child: Card(
                                child: ListTile(
                                  leading: Container(
                                    width: 5,
                                    decoration: const BoxDecoration(
                                      color: Colors.green,
                                    ),
                                  ),
                                  title: Text(
                                      'Cabinet: $cabinetName'
                                    // 'Số tủ: $boxName',
                                  ),
                                  subtitle: Text(
                                    'Trạng thái: $status\n'
                                        'Thời hạn: $validDate',
                                  ),
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
                                                // boxName: boxName,
                                                // status: status,
                                                // validDate: validDate,
                                                //  onCancel: () {
                                                //  setState(() {});
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
                            );
                          },
                        ),
                      ),
                    ],
                  );

              default:
                return const Center(
                  child: CircularProgressIndicator(),
                );
            }
          },
        ),
      ),
      // SingleChildScrollView(
      //   scrollDirection: Axis.vertical,
      //   child: Card(
      //                   child: ListTile(
      //                     leading: Container(
      //                       width: 5,
      //                       height: 50,
      //                       decoration: BoxDecoration(
      //                         color: Colors.green,
      //                       ),
      //                     ),
      //                     title: Text("data.dateTime.toString()"),
      //                     subtitle: Text('Task:'),
      //                     trailing: TextButton(
      //                       onPressed: () {
      //                         if (context.mounted) {
      //                           Navigator.push(
      //                             context,
      //                             MaterialPageRoute(
      //                               builder: (context) =>
      //                                   HistoryDetail(
      //                                     // bookingId: "bookingId",
      //                                     // boxId: boxId,
      //                                     // cabinetName: cabinetName,
      //                                     // // boxName: boxName,
      //                                     // status: status,
      //                                     // validDate: validDate,
      //                                     // onCancel: () {
      //                                     //   setState(() {});
      //                                     // },
      //                                   ),
      //                             ),
      //                           );
      //                         }
      //                       },
      //                       child: const Text("Chi tiết"),
      //                     ),
      //                   ),
      //                 ),
      //   ),
    );
  }

}
