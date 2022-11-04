import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stv_test/data_source/schedule.dart';
import 'package:stv_test/model/calendar.dart';

class SchedulePageComponent extends StatelessWidget {
  const SchedulePageComponent({
    super.key,
    required this.selectedDate,
    required this.createSchedule,
    required this.updateSchedule,
    required this.swipe,
    required this.schedules,
  });

  final DateTime selectedDate;
  final List<ScheduleData> schedules;
  final Function(DateTime) createSchedule;
  final Function(ScheduleData) updateSchedule;

  /// カードをスワイプした時の処理
  final Function(int) swipe;

  @override
  Widget build(BuildContext context) {
    /// 表示するページ
    final pages = [
      scheduleCard(
        context: context,
        selectedDate: selectedDate,
        create: createSchedule,
        update: updateSchedule,
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

        /// スワイプに応じて日付を更新
        onPageChanged: swipe,
      ),
    );
  }

  scheduleCard({
    required BuildContext context,

    /// セルデータ
    required DateTime selectedDate,

    /// 新規作成
    required void Function(DateTime) create,

    /// 編集
    required void Function(ScheduleData) update,
  }) {
    /// 日付フォーマット
    final dateFormat = DateFormat('yyyy/MM/dd');
    final weekText = DateFormat.E('ja').format(selectedDate);

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
                    '${dateFormat.format(selectedDate)} （$weekText）',
                    style: const TextStyle(
                        fontWeight: FontWeight.w500, fontSize: 20),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.add,
                      color: Colors.blue,
                    ),
                    onPressed: () => create(selectedDate),
                  ),
                ],
              ),
            ),

            const Divider(),

            /// 予定がない
            if (schedules.isEmpty) unscheduledCard(),

            /// 予定がある
            if (schedules.isNotEmpty)

              /// 終日でない予定
              Column(
                children: schedules
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
              children: schedules
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
