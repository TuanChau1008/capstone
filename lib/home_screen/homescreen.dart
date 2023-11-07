import 'dart:math';

import  'package:capstone/utils/constants/color_constant.dart';
import 'package:capstone/utils/constants/image_constant.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../dialogs/error_dialog.dart';
import '../dialogs/generic_dialog.dart';
import '../dialogs/loading_dialog.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);


  @override
  State<HomeScreen> createState() => _HomeScreen();


}
class _HomeScreen extends State<HomeScreen> {
  DatabaseReference firebase = FirebaseDatabase.instance.ref("/");
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstant.primaryColor,
        automaticallyImplyLeading: false,
        title: Text("Trang Chủ"),
        actions: [
          GestureDetector(
            onTap: () {},
            child: Image.asset(
              ImageConstant.icAdd,
              height: size.height * 0.03,
              width: size.height * 0.03,
              color: ColorConstant.primaryColor,
            ),
          ),
        ],
      ),
      body: Material(
        color: Colors.white,
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Flexible(
                child: FractionallySizedBox(
                  heightFactor: 0.85,
                ),
              ),
              Container(
                padding: EdgeInsets.all(size.height * 0.02),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(size.height * 0.03),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: InkWell(

                  onTap: () {
                    String BookingCodeId = generateRandomCode(18);
                    String id = BookingCodeId;
                    DatabaseReference bookingOrder = FirebaseDatabase.instance.ref().child('BookingCode').child('-N'+id);
                    DateTime now = DateTime.now().add(const Duration(minutes: 10));
                    String time = now.toString().substring(0,16);
                    var rng = new Random();
                    var code = rng.nextInt(900000) + 100000;
                    String bcode = code.toString();
                    Map<String, String> booking =
                    {
                      "bcode": bcode,
                      "bookingId": "-N$id",
                      "id": "-Nh16BxBtkcOUl6_uoHG",
                      "status": "1",
                      "validDate": time
                    };
                    bookingOrder.update(booking);
                     if (context.mounted) {
                      createNewBookingCode(context, "1", "Nh16BmWda5wbyrO3MQG", bcode);
                     }
                  },
                  child: Column(
                    children: [
                      Container(
                        width: size.width * 0.5,
                        height: size.width * 0.4,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(ImageConstant.imgCreateBooking),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Text(
                        "Tạo mã hòm thư",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: size.height * 0.03,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const Flexible(
                child: FractionallySizedBox(
                  heightFactor: 0.9,
                ),
              ),
              Container(
                padding: EdgeInsets.all(size.height * 0.02),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(size.height * 0.03),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: InkWell(
                  onTap: () {
                    if (context.mounted) {
                    }
                  },
                  child: Column(
                    children: [
                      Container(
                        width: size.width * 0.5,
                        height: size.width * 0.4,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(ImageConstant.imgViewHistory),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Text(
                        "Xem hòm thư",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: size.height * 0.03,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const Flexible(
                child: FractionallySizedBox(
                  heightFactor: 0.05,
                ),
              ),
            ],
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
  }

