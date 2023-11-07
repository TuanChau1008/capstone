import 'package:firebase_database/firebase_database.dart';

class History {
  late String id;
  late String boxName;
  late String createDate;
  late String endDate;
  late int status;

  History({
    required this.id,
    required this.boxName,
    required this.createDate,
    required this.endDate,
    required this.status,
  });

  History.fromSnapshot(DataSnapshot snapshot){
    Map<dynamic, dynamic> myData= Map<dynamic, dynamic>.from(snapshot.value as
    Map);
    id = snapshot.key.toString();
    boxName = myData["BoxName"].toString();
    createDate =myData["CreateDate"].toString();
    endDate = myData["EndDate"].toString();
    status = myData["Status"].toInt();
  }

  Map<dynamic, dynamic> toJson() {
    return {
      "BoxName": boxName,
      "CreateDate": createDate,
      "EndDate": endDate,
      "Status": status
    };
  }
}