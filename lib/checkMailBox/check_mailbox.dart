import 'dart:core';
import 'dart:math';

import 'package:capstone/utils/constants/color_constant.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../dialogs/error_dialog.dart';
import '../dialogs/generic_dialog.dart';
import '../dialogs/loading_dialog.dart';
import '../services/api.dart';

class CheckMailBox extends StatefulWidget {
  const CheckMailBox({super.key});
  @override
  State<CheckMailBox> createState() => _CheckMailBoxState();
}

class _CheckMailBoxState extends State<CheckMailBox> {
  @override
  Widget build(BuildContext context) {
    late String bookingCode;
    late String masterCode;
    late String boxName;
    late String validDate;
    late String createDate;
    late String status = "";
    late String bookingId;
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstant.primaryColor,
        title: const Text("Chi tiết hòm thư"),
      ),
      body: Center(
        child: Card(
          elevation: 10.0,
          child: FractionallySizedBox(
            widthFactor: 0.9,
            heightFactor: 0.95,
            child: FutureBuilder(
              future: Api.fetchMailBoxLog(),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  case ConnectionState.done:
                    int index = 0;
                    bookingCode =
                    snapshot.data![index]["UnlockCode"].toString();
                    masterCode =
                    snapshot.data![index]["MasterCode"].toString();
                    bookingId =
                    snapshot.data![index]["BookingId"].toString();
                    boxName =
                    snapshot.data![index]["BoxName"].toString();
                    // String boxName = snapshot.data![index]['BoxName'];
                    validDate =
                    snapshot.data![index]['EndDate'];
                    createDate =
                    snapshot.data![index]['CreateDate'];
                    if (snapshot.data![index]['Status'].toString() == '2') {
                      status = "Đang tiến hành";
                    } else if (snapshot.data![index]['Status'].toString() == '3') {
                      status = "Đang có hàng";
                    } else if (snapshot.data![index]['Status'].toString() == '4') {
                      status = "Hoàn thành";
                    } else if (snapshot.data![index]['Status'].toString() == '5') {
                      status = "Đã Hủy";
                    }
                    return Padding(
                      padding: EdgeInsets.fromLTRB(
                        15.0,
                        size.height * 0.03,
                        15.0,
                        size.height * 0.03,
                      ),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Tên tủ: ",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                boxName,
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: size.height * 0.05,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Trạng thái: ",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                status,
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: size.height * 0.05,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Mã mở tủ: ",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                bookingCode,
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: size.height * 0.05,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Master code: ",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                masterCode,
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: size.height * 0.05,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Ngày tạo: ",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                               createDate,
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: size.height * 0.05,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Thời hạn: ",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                validDate,
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: size.height * 0.05,
                          ),
                          FractionallySizedBox(
                            widthFactor: 1,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                              onPressed: () {
                                String id = bookingId;
                                DatabaseReference bookingOrder = FirebaseDatabase.instance.ref().child('BookingCode').child("$id");
                                DateTime now = DateTime.now().add(const Duration(minutes: 10));
                                String time = now.toString().substring(0,16);
                                var rng = new Random();
                                var code = rng.nextInt(900000) + 100000;
                                String bcode = code.toString();
                                Map<String, String> booking =
                                {
                                  "bcode": bcode,
                                  "bookingId": "-Ni8Zv8DYrsm3bMZ7eB2",
                                  "id": "$id",
                                  "status": "1",
                                  "validDate": time
                                };
                                bookingOrder.update(booking);
                                if (context.mounted) {
                                  createNewBookingCode(context, "1", id, bcode);
                                }
                                setState(() {
                                  bookingCode = bcode;
                                });
                              },
                              child: const Text(
                                "Mã booking mới",
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.005,
                          ),
                          FractionallySizedBox(
                            widthFactor: 1,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                              onPressed: () {
                                String id = bookingId;
                                String BookingCodeId = generateRandomCode(18);
                                DatabaseReference bookingOrder = FirebaseDatabase.instance.ref().child('BookingCode').child(id);
                                DatabaseReference history = FirebaseDatabase.instance.ref().child('History').child(BookingCodeId);
                                DatabaseReference log = FirebaseDatabase.instance.ref().child('MailBoxLog').child("Log");
                                DateTime now = DateTime.now().add(const Duration(minutes: 10));
                                String time = now.toString().substring(0,16);
                                var rng = new Random();
                                var code = rng.nextInt(900000) + 100000;
                                String bcode = code.toString();
                                Map<String, String> booking =
                                {
                                  "bcode": bcode,
                                  "bookingId": "-Ni8Zv8DYrsm3bMZ7eB2",
                                  "id": "-N$id",
                                  "status": "5",
                                  "validDate": time
                                };
                                bookingOrder.update(booking);
                                Map<String, dynamic> cancel =
                                {
                                  "BookingId": id,
                                  "BoxName": "MailBox",
                                  "CreateDate": createDate,
                                  "EndDate": validDate,
                                  "MasterCode": 123456,
                                  "Status": "5",
                                  "UnlockCode": bcode
                                };
                                history.update(cancel);
                                log.update(cancel);
                                cancelBooking(
                                  context,
                                    status
                                );
                              },
                              child: const Text(
                                "Hủy booking",
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  default:
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
  String generateRandomCode(int len) {
    var r = Random();
    const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    return List.generate(len, (index) => _chars[r.nextInt(_chars.length)]).join();
  }
  Future<void> createNewBookingCode(
      BuildContext mainContext,
      String status,
      String bookingId,
      String oldCode,
      ) async {
    closeLoadingDialog();
    if (context.mounted) {
      await showGenericDialog(
        context: context,
        title: "Tạo mã booking",
        content:
        "Mã booking mới là: $oldCode. Chú ý: mã có hiệu lực 10 phút",
        optionBuilder: () => {
          "OK": true,
        },
      );
    }
  }

  Future<void> cancelBooking(
      BuildContext mainContext,
      String status,
      ) async {
    if (status.contains("Đang có hàng")) {
      if (context.mounted) {
        return showErrorDialog(
            context, "Bạn không thể hủy booking đang có hàng trong tủ");
      }
    } else if (status.contains("Đang tiến hành")) {

        if (context.mounted) {
          Navigator.pop(mainContext);

          await showGenericDialog(
            context: context,
            title: "Hủy booking",
            content: "Booking được hủy thành công",
            optionBuilder: () => {"OK": true},
          );
        }

    }
  }
}
