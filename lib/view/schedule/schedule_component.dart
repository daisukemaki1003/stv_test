import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stv_test/data_source/schedule.dart';
import 'package:stv_test/model/calendar.dart';

class SchedulePageComponent extends StatefulWidget {
  const SchedulePageComponent({
    super.key,
    required this.calendarCell,
    required this.createSchedule,
    required this.updateSchedule,
    required this.onPrevDay,
    required this.onNextDay,
  });

  final Calendar calendarCell;
  final Function(DateTime) createSchedule;
  final Function(ScheduleData) updateSchedule;

  final Function() onPrevDay;
  final Function() onNextDay;

  @override
  State<SchedulePageComponent> createState() => SchedulePageComponentState();
}

class SchedulePageComponentState extends State<SchedulePageComponent> {
  @override
  Widget build(BuildContext context) {
    /// PageViewのインデックス
    int pageIndex = 0;

    /// 表示するページ
    final pages = [
      scheduleCard(
        context: context,
        cell: widget.calendarCell,
        create: widget.createSchedule,
        update: widget.updateSchedule,
      )
    ];

    return Container(
      height: 600,
      alignment: Alignment.bottomCenter,
      color: Colors.transparent,
      child: PageView.builder(
        controller: PageController(viewportFraction: 0.9, initialPage: 999),
        itemBuilder: (context, index) {
          return pages[index % pages.length];
        },
        onPageChanged: (index) {
          /// スワイプに応じて日付を更新
          if (pageIndex < index) {
            widget.onNextDay();
          } else {
            widget.onPrevDay();
          }

          setState(() {
            pageIndex = index;
          });
        },
      ),
    );
  }

  scheduleCard({
    required BuildContext context,

    /// セルデータ
    required Calendar cell,

    /// 新規作成
    required void Function(DateTime) create,

    /// 編集
    required void Function(ScheduleData) update,
  }) {
    /// 日付フォーマット
    final dateFormat = DateFormat('yyyy/M/d');
    final weekText = DateFormat.E('ja').format(cell.date);

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
              padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${dateFormat.format(cell.date)} （$weekText）',
                    style: const TextStyle(
                        fontWeight: FontWeight.w500, fontSize: 20),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.add,
                      color: Colors.blue,
                    ),
                    onPressed: () => create(cell.date),
                  ),
                ],
              ),
            ),

            const Divider(),

            /// 予定がない
            if (cell.schedules.isEmpty) unscheduledCard(),

            /// 予定がある
            if (cell.schedules.isNotEmpty)

              /// 終日でない予定
              Column(
                children: cell.schedules
                    .where((schedule) => !schedule.isAllDay)
                    .toList()
                    .map((e) => scheduleTile(
                          schedule: e,
                          onTap: update,
                        ))
                    .toList(),
              ),

            /// 終日の予定
            Column(
              children: cell.schedules
                  .where((schedule) => schedule.isAllDay)
                  .toList()
                  .map((e) => scheduleTile(
                        schedule: e,
                        onTap: update,
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget scheduleTile({
    required ScheduleData schedule,
    required Function(ScheduleData) onTap,
  }) {
    final dateFormat = DateFormat('HH:mm');

    return Column(
      children: [
        InkWell(
          onTap: () => onTap(schedule),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              children: [
                SizedBox(
                  width: 45,
                  child: schedule.isAllDay
                      ? const Center(child: Text("終日"))
                      : Column(
                          children: [
                            Text(dateFormat.format(schedule.from)),
                            Text(dateFormat.format(schedule.to)),
                          ],
                        ),
                ),
                const SizedBox(
                  height: 50,
                  child: VerticalDivider(
                    width: 30,
                    thickness: 5,
                    color: Colors.blue,
                  ),
                ),
                Expanded(
                  child: Text(
                    schedule.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
        ),
        const Divider(),
      ],
    );
  }

  unscheduledCard() {
    return const Expanded(
      child: Center(
        child: Text("予定がありません"),
      ),
    );
  }
}
