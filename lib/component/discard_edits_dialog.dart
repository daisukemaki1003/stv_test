import 'package:flutter/cupertino.dart';

Future<bool?> discardEditsDialog({
  required BuildContext context,
  required String actionText,
}) {
  return showCupertinoModalPopup<bool>(
    context: context,
    builder: (BuildContext context) {
      return CupertinoActionSheet(
        actions: <Widget>[
          CupertinoActionSheetAction(
            isDestructiveAction: true,
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(actionText),
          )
        ],
        cancelButton: CupertinoActionSheetAction(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text("キャンセル"),
        ),
      );
    },
  );
}
