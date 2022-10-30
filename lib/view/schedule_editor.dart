import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stv_test/constraints/color.dart';

class ScheduleEditor extends StatelessWidget {
  const ScheduleEditor({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: defaultColor,
      appBar: AppBar(
        title: const Text("予定の追加"),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: TextButton(
              onPressed: () {},
              child: Text("保存"),
              style: TextButton.styleFrom(
                backgroundColor: defaultColor,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            children: [
              /// タイトル
              Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: titleInputField(),
              ),

              /// 予定日選択
              scheduledDateSelectionTile(),

              /// コメント
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: commentInputField(),
              ),

              /// 削除ボタン
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: deleteButton(context),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget deleteButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        style: TextButton.styleFrom(
          backgroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 20),
        ),
        child: const Text(
          'この予定を削除',
          style: TextStyle(color: Colors.red),
        ),
        onPressed: () {
          _showAlertDialog(context);
        },
      ),
    );
  }

  void discardEditsDialog(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return CupertinoActionSheet(
          actions: <Widget>[
            CupertinoActionSheetAction(
              isDestructiveAction: true,
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("編集を破棄"),
            )
          ],
          cancelButton: CupertinoActionSheetAction(
            child: const Text("キャンセル"),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        );
      },
    );
  }

  void _showAlertDialog(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text('予定の削除'),
        content: const Text('本当にこの日の予定を削除しますか？'),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            textStyle: const TextStyle(color: Colors.blue),
            child: const Text('キャンセル'),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            textStyle: const TextStyle(color: Colors.blue),
            child: const Text('削除'),
          )
        ],
      ),
    );
  }

  Widget commentInputField() {
    return TextFormField(
      minLines: 5,
      maxLines: 15,
      decoration: InputDecoration(
        hintText: 'コメントを入力してください',
        hintStyle: const TextStyle(color: Colors.black12),
        fillColor: Colors.white,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide.none,
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(width: 2.0, color: Colors.blue),
        ),
      ),
    );
  }

  Widget scheduledDateSelectionTile() {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          SwitchListTile(
            value: true,
            title: const Text("終日"),
            onChanged: (bool value) {},
          ),
          ListTile(
            title: const Text("終日"),
            trailing: TextButton(
              onPressed: () {},
              child: const Text("2018-08-03 10:00"),
            ),
          ),
          ListTile(
            title: const Text("終了"),
            trailing: TextButton(
              onPressed: () {},
              child: const Text("2018-08-03 10:00"),
            ),
          ),
        ],
      ),
    );
  }

  Widget titleInputField() {
    return TextFormField(
      decoration: InputDecoration(
        hintText: 'タイトルを入力してください',
        hintStyle: const TextStyle(color: Colors.black12),
        fillColor: Colors.white,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide.none,
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(width: 2.0, color: Colors.blue),
        ),
      ),
    );
  }
}
