import 'package:firebase_database/firebase_database.dart';

class MailBoxLogModel {
  String? id;
  String? boxName;
  String? createDate;
  String? endDate;
  int? status;
  int? bCode;
  int? masterCode;

  MailBoxLogModel({
    this.id,
    this.boxName,
    this.createDate,
    this.endDate,
    this.status,
  });

  MailBoxLogModel.fromSnapshot(DataSnapshot snapshot){
    Map<dynamic, dynamic> myData= Map<dynamic, dynamic>.from(snapshot.value as
    Map);
    id = snapshot.key.toString();
    boxName = myData["BoxName"].toString();
    createDate =myData["CreateDate"].toString();
    endDate = myData["EndDate"].toString();
    status = myData["Status"].toInt();
    masterCode = myData["MasterCode"].toInt();
    bCode = myData["UnlockCode"].toInt();
  }

  Map<dynamic, dynamic> toJson() {
    return {
      "BoxName": boxName,
      "CreateDate": createDate,
      "EndDate": endDate,
      "Status": status,
      "MasterCode": masterCode,
      "UnlockCode": bCode,
    };
  }
}