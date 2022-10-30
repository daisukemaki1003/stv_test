import 'package:flutter/material.dart';
import 'package:stv_test/view/schedule_edit.dart';

class SchedulePage extends StatelessWidget {
  const SchedulePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600,
      alignment: Alignment.bottomCenter,
      color: Colors.transparent,
      child: PageView(
        controller: PageController(viewportFraction: 0.9),
        children: [
          scheduleCard(context),
          scheduleCard(context),
          scheduleCard(context),
          scheduleCard(context),
          scheduleCard(context),
          scheduleCard(context),
          scheduleCard(context),
        ],
      ),
    );
  }

  scheduleCard(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        child: Column(
          children: [
            /// タイトル
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "2021/10/03 (月)",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      Navigator.pushNamed(context, ScheduleEditPage.routeName);
                    },
                  ),
                ],
              ),
            ),

            const Divider(),

            /// 予定が存在するか
            scheduleTile(),
          ],
        ),
      ),
    );
  }

  Widget scheduleTile() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        children: [
          Column(
            children: const [
              Text("10:00"),
              Text("11:00"),
            ],
          ),
          const SizedBox(
            height: 50,
            child: VerticalDivider(
              width: 30,
              thickness: 5,
              color: Colors.blue,
            ),
          ),
          const Expanded(
            child: Text(
              "タイトルタイトルタイトルタイトルタイトルタイトルタイトルタイトルタイトルタイトルタイトル",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }

  unscheduledCard() {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        child: Center(
          child: Text("予定がありません"),
        ),
      ),
    );
  }
}