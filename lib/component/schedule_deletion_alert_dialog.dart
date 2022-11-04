import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<bool?> deletionAlertDialog({
  required BuildContext context,
  required String title,
  required String content,
}) {
  return showCupertinoModalPopup<bool>(
    context: context,
    builder: (BuildContext context) => CupertinoAlertDialog(
      title: Text(title),
      content: Text(content),
      actions: <CupertinoDialogAction>[
        CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: () => Navigator.of(context).pop(false),
          textStyle: const TextStyle(color: Colors.blue),
          child: const Text('キャンセル'),
        ),
        CupertinoDialogAction(
          isDestructiveAction: true,
          onPressed: () => Navigator.of(context).pop(true),
          textStyle: const TextStyle(color: Colors.blue),
          child: const Text('削除'),
        )
      ],
    ),
  );
}
