import 'package:flutter/material.dart';
import '/dialogs/generic_dialog.dart';

Future<bool> showCancelProcessBookingDialog(BuildContext context) {
  return showGenericDialog<bool>(
    context: context,
    title: "Hủy booking",
    content: "Bạn có muốn hủy booking này?",
    optionBuilder: () => {
      "Cancel": false,
      "Xác nhận": true,
    },
  ).then(
    (value) => value ?? false,
  );
}
