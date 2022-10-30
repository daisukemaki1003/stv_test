import 'package:flutter/material.dart';
import 'package:stv_test/constraints/color.dart';

class ScheduleEditor extends StatelessWidget {
  const ScheduleEditor({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: defaultColor,
      appBar: AppBar(title: const Text("予定の追加")),
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
                child: deleteButton(),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget deleteButton() {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        style: TextButton.styleFrom(
          backgroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 20),
        ),
        onPressed: () {},
        child: const Text(
          'この予定を削除',
          style: TextStyle(color: Colors.red),
        ),
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
