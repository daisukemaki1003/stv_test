import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stv_test/constraints/text.dart';
import 'package:stv_test/data_source/schedule.dart';

class SchedulePageComponent extends StatelessWidget {
  const SchedulePageComponent({
    super.key,
    required this.selectedDate,
    required this.createSchedule,
    required this.updateSchedule,
    required this.fetchSchedule,
  });

  final DateTime selectedDate;
  final Function(DateTime) createSchedule;
  final Function(ScheduleData) updateSchedule;
  final Function(DateTime) fetchSchedule;

  @override
  Widget build(BuildContext context) {
    int initialPage = 999;
    final controller =
        PageController(viewportFraction: 0.9, initialPage: initialPage);
    return Container(
      height: 600,
      alignment: Alignment.bottomCenter,
      color: Colors.transparent,
      child: PageView.builder(
        controller: controller,
        itemBuilder: (_, index) {
          final date = selectedDate.add(Duration(days: index - initialPage));
          return scheduleCard(
            context: context,
            selectedDate: date,
            create: createSchedule,
            update: updateSchedule,
            schedules: fetchSchedule(date),
          );
        },
      ),
    );
  }

  scheduleCard({
    required BuildContext context,

    /// セルデータ
    required DateTime selectedDate,

    /// 新規作成
    required Function(DateTime) create,

    /// 編集
    required Function(ScheduleData) update,
    required List<ScheduleData> schedules,
  }) {
    /// 日付フォーマット
    final dateFormat = kSchedulePageLabelDateFormat;
    final weekText = kSchedulePageWeekLabelDateFormat.format(selectedDate);

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
                          onTap: () => update(e),
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
                        onTap: () => update(e),
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
    required Function() onTap,
  }) {
    final dateFormat = kSchedulePageEstimatedTimeDateFormat;

    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              children: [
                SizedBox(
                  width: 45,
                  child: schedule.isAllDay
                      ? const Center(child: Text(kSchedulePageAllDayText))
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
        child: Text(kSchedulePageNoPlanText),
      ),
    );
  }
}
