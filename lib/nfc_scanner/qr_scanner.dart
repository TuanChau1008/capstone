// import 'dart:typed_data';
//
// import 'package:capstone/services/api.dart';
// import 'package:flutter/material.dart';
// import 'package:mobile_scanner/mobile_scanner.dart';
// import 'package:nfc_manager/nfc_manager.dart';
//
// import '../utils/constants/color_constant.dart';
// import '../utils/constants/image_constant.dart';
//
// const bgColor = Color(0xfffafafa);
//
// class QRscanner extends StatefulWidget {
//   const QRscanner({super.key});
//
//   @override
//   State<QRscanner> createState() => _QRscannerState();
// }
//
// class _QRscannerState extends State<QRscanner> {
//   @override
//   void initState() {
//     super.initState();
//     _ndefWrite();
//   }
//   TextEditingController _textController = TextEditingController();
//   ValueNotifier<dynamic> result = ValueNotifier(null);
//
//   @override
//   Widget build(BuildContext context) {
//     var size = MediaQuery.of(context).size;
//     return Scaffold(
//       appBar: AppBar(
//           backgroundColor: ColorConstant.primaryColor,
//           title: Text('Mở cửa bằng NFC'),
//       ),
//       body: Center(
//         child: FutureBuilder<bool>(
//           future: NfcManager.instance.isAvailable(),
//           builder: (context, ss) => ss.data != true
//               ? Center(child: Text('NfcManager.isAvailable(): ${ss.data}'))
//               : Flex(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             direction: Axis.vertical,
//             children: [
//               Image.asset(
//                 ImageConstant.icNFC,
//                 height: size.height * 0.7,
//                 width: size.height * 0.7,
//                 color: ColorConstant.primaryColor,
//               ),
//                     ElevatedButton(
//                         onPressed: _ndefWrite,
//                         child: const Text('Mở cửa bằng NFC')),
//             ],
//           ),
//         ),
//
//       ),
//     );
//   }
//
//   void _ndefWrite() {
//     String cabinet = '123456';
//     Api.fetchMasterCode().then((value) =>{
//       cabinet = value,
//       print(cabinet)
//
//     }
//     );
//
//
//     NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
//       var ndef = Ndef.from(tag);
//       if (ndef == null || !ndef.isWritable) {
//         result.value = 'Tag is not ndef writable';
//         NfcManager.instance.stopSession(errorMessage: result.value);
//         return;
//       }
//
//       NdefMessage message = NdefMessage([
//         NdefRecord.createText(cabinet),
//       ]);
//
//       try {
//         await ndef.write(message);
//         result.value = 'Success to "Ndef Write"';
//         NfcManager.instance.stopSession();
//       } catch (e) {
//         result.value = e;
//         NfcManager.instance.stopSession(errorMessage: result.value.toString());
//         return;
//       }
//     });
//   }
//
//   @override
//   void dispose() {
//     NfcManager.instance.stopSession();
//     super.dispose();
//   }
//
// }
