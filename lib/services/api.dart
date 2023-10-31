// import 'dart:convert';
//
// import 'package:flutter/foundation.dart';
// import 'package:http/http.dart' as http;
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:platform_device_id/platform_device_id.dart';
//
// final _firebaseMessaging = FirebaseMessaging.instance;
// const storage = FlutterSecureStorage();
//
//
//
// class LocationApi {
//   Future<List<dynamic>> getLocationByBusinessId() async {
//     final businessId = await storage.read(key: "business_id");
//     final uri = Uri.parse(
//         '$mainURL/customer/search-location-by-businessId?businessId=$businessId');
//     final token = await storage.read(key: 'access_token');
//     final header = {
//       'Content-type': 'application/json',
//       'Accept': 'application/json',
//       'Authorization': 'Bearer $token',
//     };
//
//     final response = await http.get(
//       uri,
//       headers: header,
//     );
//
//     final results = json.decode(utf8.decode(response.bodyBytes));
//
//     List<dynamic> resultList = [];
//
//     if (response.statusCode == 200) {
//       resultList = results['data'];
//     } else if (response.statusCode == 400) {
//       throw Exception("${results.error}");
//     }
//
//     return resultList;
//   }
// }
//
//
// class BookingApi {
//   Future<dynamic> addNewBooking(
//     CreateNewBookingRequest request,
//   ) async {
//     final token = await storage.read(key: 'access_token');
//     final uri = Uri.parse('$mainURL/customer/add-new-booking');
//     final msg = jsonEncode(request);
//     final header = {
//       'Content-type': 'application/json',
//       'Accept': 'application/json',
//       'Authorization': 'Bearer $token',
//     };
//
//     final response = await http.post(
//       uri,
//       headers: header,
//       body: msg,
//     );
//
//     if (response.statusCode == 200) {
//       return CreateNewBookingResponse.fromJson(
//           json.decode(utf8.decode(response.bodyBytes)));
//     } else if (response.statusCode == 400) {
//       if (kDebugMode) {
//         print(response.statusCode);
//         print(response.body);
//       }
//     }
//   }
//
//   // Future<BookingDetailsResponse> fetchBookingDetails(
//   //   String bookingId,
//   //   String boxId,
//   // ) async {
//   //   final token = await storage.read(key: 'access_token');
//   //   final uri = Uri.parse(
//   //       '$mainURL/customer/get-booking-details?bookingId=$bookingId&boxId=$boxId');
//   //
//   //   final header = {
//   //     'Content-type': 'application/json',
//   //     'Accept': 'application/json',
//   //     'Authorization': 'Bearer $token',
//   //   };
//   //
//   //   final response = await http.get(
//   //     uri,
//   //     headers: header,
//   //   );
//   //
//   //   BookingDetailsResponse result = BookingDetailsResponse();
//   //
//   //   if (response.statusCode == 200) {
//   //     result = BookingDetailsResponse.fromJson(
//   //         json.decode(utf8.decode(response.bodyBytes)));
//   //   } else if (response.statusCode == 400) {
//   //     if (kDebugMode) {
//   //       print(response.statusCode);
//   //       print(response.body);
//   //     }
//   //   }
//   //
//   //   return result;
//   // }
//   //
//   // Future<GenericResponse> cancelProcessingBooking(
//   //   String bookingId,
//   //   String oldBookingCode,
//   //   String boxId,
//   // ) async {
//   //   final token = await storage.read(key: 'access_token');
//   //   final uri = Uri.parse('$mainURL/customer/cancel-processing-booking');
//   //   final msg = jsonEncode(<String, String>{
//   //     'bookingId': bookingId,
//   //     'oldBookingCode': oldBookingCode,
//   //     'boxId': boxId,
//   //   });
//   //
//   //   final header = {
//   //     'Content-type': 'application/json',
//   //     'Accept': 'application/json',
//   //     'Authorization': 'Bearer $token',
//   //   };
//   //
//   //   final response = await http.post(
//   //     uri,
//   //     headers: header,
//   //     body: msg,
//   //   );
//   //
//   //   return GenericResponse.fromJson(
//   //       json.decode(utf8.decode(response.bodyBytes)));
//   // }
//   //
//   // Future<UpdateUnlockCodeResponse> updateUnlockCode(
//   //   String bookingId,
//   // ) async {
//   //   final token = await storage.read(key: 'access_token');
//   //   final uri =
//   //       Uri.parse('$mainURL/customer/update-unlock-code?bookingId=$bookingId');
//   //
//   //   final header = {
//   //     'Content-type': 'application/json',
//   //     'Accept': 'application/json',
//   //     'Authorization': 'Bearer $token',
//   //   };
//   //
//   //   final response = await http.post(
//   //     uri,
//   //     headers: header,
//   //   );
//   //
//   //   return UpdateUnlockCodeResponse.fromJson(
//   //       json.decode(utf8.decode(response.bodyBytes)));
//   // }
//
//   Future<CreateNewBookingCodeResponse> createNewBookingCode(
//       CreateNewBookingCodeRequest request) async {
//     final token = await storage.read(key: 'access_token');
//     final uri = Uri.parse('$mainURL/customer/create-new-booking-code');
//     final msg = jsonEncode(request);
//
//     final header = {
//       'Content-type': 'application/json',
//       'Accept': 'application/json',
//       'Authorization': 'Bearer $token',
//     };
//
//     final response = await http.post(
//       uri,
//       headers: header,
//       body: msg,
//     );
//
//     CreateNewBookingCodeResponse result = CreateNewBookingCodeResponse();
//
//     if (response.statusCode == 200) {
//       result = CreateNewBookingCodeResponse.fromJson(
//           json.decode(utf8.decode(response.bodyBytes)));
//     } else if (response.statusCode == 400) {
//       if (kDebugMode) {
//         print(response.statusCode);
//         print(response.body);
//       }
//     }
//
//     return result;
//   }
// }
//
// class BookingHistoryApi {
//   Future<List<dynamic>> fetchBookingHistory() async {
//     final deviceId = await storage.read(key: "device_id");
//     final businessId = await storage.read(key: "business_id");
//     final token = await storage.read(key: 'access_token');
//     final uri = Uri.parse(
//         '$mainURL/customer/get-booking-history?deviceId=$deviceId&businessId=$businessId');
//
//     final header = {
//       'Content-type': 'application/json',
//       'Accept': 'application/json',
//       'Authorization': 'Bearer $token',
//     };
//
//     final response = await http.get(
//       uri,
//       headers: header,
//     );
//
//     final result = json.decode(utf8.decode(response.bodyBytes));
//
//     List<dynamic> resultList = [];
//
//     if (response.statusCode == 200) {
//       resultList = result['data'];
//       return resultList;
//     } else {
//       if (kDebugMode) {
//         print(response.statusCode);
//         print(response.body);
//       }
//     }
//
//     return resultList;
//   }
// }
//
// // class NotificationApi {
// //   Future<void> sendFcmToken(String deviceId) async {
// //     final currentFcmToken = await _firebaseMessaging.getToken();
// //     final uri = Uri.parse('$mainURL/notification/save-fcm-token');
// //     final msg = jsonEncode({"deviceId": deviceId, "token": currentFcmToken});
// //     final token = await storage.read(key: 'access_token');
// //     final header = {
// //       'Content-type': 'application/json',
// //       'Accept': 'application/json',
// //       'Authorization': 'Bearer $token',
// //     };
// //
// //     await http.post(
// //       uri,
// //       headers: header,
// //       body: msg,
// //     );
// //   }
// //
// //   Future<List<dynamic>> fetchNotification() async {
// //     List<dynamic> resultList = [];
// //     try {
// //       final deviceId = await storage.read(key: "device_id");
// //       final token = await storage.read(key: 'access_token');
// //       final uri =
// //           Uri.parse('$mainURL/customer/get-notification?deviceId=$deviceId');
// //
// //       final header = {
// //         'Content-type': 'application/json',
// //         'Accept': 'application/json',
// //         'Authorization': 'Bearer $token',
// //       };
// //
// //       final response = await http.get(
// //         uri,
// //         headers: header,
// //       );
// //
// //       final result = json.decode(utf8.decode(response.bodyBytes));
// //
// //       if (response.statusCode == 200) {
// //         for (var item in result['message']) {
// //           for (var itemValue in item.values) {
// //             resultList.add(itemValue);
// //           }
// //         }
// //       } else {
// //         if (kDebugMode) {
// //           print(response.statusCode);
// //           print(response.body);
// //         }
// //       }
// //     } catch (e) {
// //       return resultList;
// //     }
// //
// //     return resultList;
// //   }
// }
