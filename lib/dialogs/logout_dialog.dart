import 'package:flutter/material.dart';

import '/dialogs/generic_dialog.dart';

Future<bool> showLogoutDialog(BuildContext context) {
  return showGenericDialog<bool>(
    context: context,
    title: "Đăng xuất",
    content: "Đăng xuất khỏi tài khoản này?",
    optionBuilder: () => {
      "Trở lại": false,
      "Đăng xuất": true,
    },
  ).then(
    (value) => value ?? false,
  );
}
