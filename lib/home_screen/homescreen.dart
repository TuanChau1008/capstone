import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:capstone/services/api.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import 'package:capstone/checkMailBox/check_mailbox.dart';
import  'package:capstone/utils/constants/color_constant.dart';
import 'package:capstone/utils/constants/image_constant.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';
import '../dialogs/generic_dialog.dart';
import '../dialogs/loading_dialog.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);


  @override
  State<HomeScreen> createState() => _HomeScreen();


}
class _HomeScreen extends State<HomeScreen> {
  DatabaseReference firebase = FirebaseDatabase.instance.ref("/");
  final _screenshotController = ScreenshotController();
  Future<Image>? image;
  bool visible = false;
  String bcode = '';
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

                  onTap: () async {
                    String BookingCodeId = generateRandomCode(18);
                    String id = BookingCodeId;
                    DatabaseReference bookingLog = FirebaseDatabase.instance.ref().child('BookingCode');
                    bookingLog.remove();
                    DatabaseReference bookingOrder = FirebaseDatabase.instance.ref().child('BookingCode').child('-N'+id);
                    DatabaseReference log = FirebaseDatabase.instance.ref().child('MailBoxLog').child('Log');
                    DatabaseReference booking1 = FirebaseDatabase.instance.ref().child('BookingOrder').child('-Ni8Zv8DYrsm3bMZ7eB2');
                    DateTime end = DateTime.now().add(const Duration(minutes: 10));
                    DateTime now = DateTime.now();
                    String endTime = end.toString().substring(0,16);
                    String time = now.toString().substring(0,16);
                    var rng = new Random();
                    var code = rng.nextInt(900000) + 100000;
                    bcode = code.toString();
                    Map<String, String> booking =
                    {
                      "bcode": bcode,
                      "bookingId": "-Ni8Zv8DYrsm3bMZ7eB2",
                      "id": "-N$id",
                      "status": "1",
                      "validDate": endTime
                    };
                    Map<String, dynamic> mailbox =
                    {
                      "BookingId": "-N$id",
                      "BoxName": "MailBox",
                      "CreateDate": time,
                      "EndDate": endTime,
                      "MasterCode": "100800",
                      "Status": "3",
                      "UnlockCode": bcode
                    };
                    Map<String, dynamic> bookingOrderLog =
                    {
                      "boxId": "-Nf5IIoTMOQ1XuN8qf_7",
                      "businessId": "-Nf5H_45gvDvWJlfVSHi",
                      "createDate": time,
                      "deviceId": "87bb999684cccb39",
                      "id": "-Ni8Zv8DYrsm3bMZ7eB2",
                      "status": 3,
                      "unlockCode": "100800",
                      "validDate": endTime
                    };
                    booking1.update(bookingOrderLog);
                    bookingOrder.update(booking);
                    log.update(mailbox);
                     if (context.mounted) {
                       setState(() {
                         visible = true;
                       });
                       await _captureAndSaveQRCode();
                       setState(() {
                         visible = false;
                       });
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const CheckMailBox()
                        ),
                      );
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
              Visibility(
                visible: visible,
                child: Screenshot(
                  controller: _screenshotController,
                  child: QrImageView(data: "Mã mở tủ: $bcode",
                    size: 200,)
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
            data: oldCode,
            optionBuilder: () => {
              "OK": true,
            },
          );
        }
    }
  Future<String> get imagePath async {
    final directory = (await getApplicationDocumentsDirectory()).path;
    return '$directory/qr.png';
  }


  Future<Image> _loadImage() async {
    return await imagePath.then((imagePath) => Image.asset(imagePath));
  }


  Future<void> _captureAndSaveQRCode() async {
    final imageDirectory = await imagePath;
    Uint8List? uint8List = await _screenshotController.capture();

    //final File newImage = await image.copy(imageDirectory);
    print(imageDirectory);

    Api.uploadImage(uint8List!);

  }


  }


