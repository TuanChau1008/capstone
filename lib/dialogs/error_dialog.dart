import 'package:flutter/material.dart';

import '/dialogs/generic_dialog.dart';

Future<void> showErrorDialog(
  BuildContext context,
  String text,
) {
  return showGenericDialog<void>(
    context: context,
    title: "Có lỗi",
    content: text,
    optionBuilder: () => {
      "OK": null,
    },
  );
}
