import 'dart:core';
import 'dart:math';

import 'package:capstone/utils/constants/color_constant.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart';
import 'package:http/http.dart' as http;
import '../dialogs/error_dialog.dart';
import '../dialogs/generic_dialog.dart';
import '../dialogs/loading_dialog.dart';

class CheckMailBox extends StatefulWidget {
  const CheckMailBox({super.key});
  @override
  State<CheckMailBox> createState() => _CheckMailBoxState();
}

class _CheckMailBoxState extends State<CheckMailBox> {
  final String imageUrl =
      'Box.jpg';

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstant.primaryColor,
        title: const Text("Xem hòm thư"),
      ),
      body: Center(
        child: Card(
          elevation: 10.0,
          child: FractionallySizedBox(
            widthFactor: 0.9,
            heightFactor: 0.95,
            child: FutureBuilder(
              future: _getImageUrl(imageUrl),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  case ConnectionState.done:
                      return RotatedBox(
                          quarterTurns: 1,
                          child:
                        Image.network(snapshot.data.toString())
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

  Future<String> _getImageUrl(String imagePath) async {
    final ref = firebase_storage.FirebaseStorage.instance.ref(imagePath);
    return await ref.getDownloadURL();
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
