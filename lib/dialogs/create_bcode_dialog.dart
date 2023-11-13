import 'package:flutter/material.dart';
import '/dialogs/generic_dialog.dart';

Future<bool> showCreateBcodeDialog(BuildContext context) {
  return showGenericDialog<bool>(
    context: context,
    title: "Tạo mã code",
    content: "Bạn có muốn tạo mã code mới",
    optionBuilder: () => {
      "Cancel": false,
      "Xác nhận": true,
    },
  ).then(
        (value) => value ?? false,
  );
}