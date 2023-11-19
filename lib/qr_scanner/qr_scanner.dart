import 'package:capstone/utils/constants/color_constant.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../services/api.dart';
import 'QRScannerOverlay.dart';
import 'foundScreen.dart';

const bgColor = Color(0xfffafafa);

class QRscanner extends StatefulWidget {
  const QRscanner({super.key});

  @override
  State<QRscanner> createState() => _QRscannerState();
}

class _QRscannerState extends State<QRscanner> {
  MobileScannerController cameraController = MobileScannerController();
  bool _sceenOpened = false;

  @override
  void initState() {
    _screenWasClosed();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstant.primaryColor,
        title: const Text("QR Code Scanner",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
        elevation: 0.0,
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(37, 210, 37, 210),
            child: MobileScanner(
              allowDuplicates: false,
              controller: cameraController,
              onDetect: _foundBarcode,
            ),
          ),
          QRScannerOverlay(overlayColour: Colors.black.withOpacity(0.5))
        ],
      ),
    );
  }

  Future<void> _foundBarcode(Barcode barcode, MobileScannerArguments? args) async {
    print(barcode);
    // if (!_sceenOpened) {
      final String code = barcode.rawValue ?? "---";
      // _sceenOpened = false;
      //here push navigator result page
      print("SCAN VALUE: ${code.toString()}");
      final snapshot = await FirebaseDatabase.instance
          .ref()
          .child("QRCode")
          .child("0849953007")
          .child("status")
          .get();
      int status = int.parse(snapshot.value.toString());
      if(status == 1){
        DatabaseReference qrCode = FirebaseDatabase.instance.ref().child('QRCode').child("0849953007");
        Map<String, dynamic> qrcode =
        {
          "masterKey": "15",
          "status": 0,
          "token": "unlockdoor"
        };
        qrCode.update(qrcode);
      }else {
        DatabaseReference qrCode = FirebaseDatabase.instance.ref().child('QRCode').child("0849953007");

        Map<String, dynamic> qrcode =
        {
          "masterKey": "15",
          "status": 1,
          "token": "unlockdoor"
        };
        qrCode.update(qrcode);
      }
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) =>
      //         FoundScreen(value: code, screenClose: _screenWasClosed),
      //   ),
      // );
    // }
  }

  void _screenWasClosed() {
    _sceenOpened = false;
  }
}