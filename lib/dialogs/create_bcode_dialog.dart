import 'package:flutter/material.dart';
import '/dialogs/generic_dialog.dart';

Future<bool> showCreateBcodeDialog(BuildContext context) {
  return showGenericDialog<bool>(
    context: context,
    title: "Tạo mã booking",
    content: "Bạn có muốn tạo mã booking mới",
    optionBuilder: () => {
      "Cancel": false,
      "Xác nhận": true,
    },
  ).then(
        (value) => value ?? false,
  );
}