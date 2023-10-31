
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

Future<void> showLoadingDialog() async {
    await EasyLoading.show(
      status: "Đang xử lí ...",
      indicator: const CircularProgressIndicator(),
      maskType: EasyLoadingMaskType.black,
    );
  }

Future<void> closeLoadingDialog() async {
    await EasyLoading.dismiss();
  }
