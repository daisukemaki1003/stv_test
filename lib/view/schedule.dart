import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:stv_test/data_source/schedule.dart';
import 'package:stv_test/model/calendar.dart';
import 'package:stv_test/repository/calendar/selector.dart';
import 'package:stv_test/routing/named_route.dart';

class SchedulePage extends ConsumerWidget {
  const SchedulePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /// 選択中の日付
    final targetDate = ref.watch(targetDateProvider.state);

    /// 選択中のカレンダーセルデータ
    final targetCell = ref.watch(targetCellProvider.state);

    /// 表示するページ
    final pages = [
      scheduleCard(
        context: context,
        cell: targetCell.state,
        onPressed: () => context.push(scheduleEditPath),
      )
    ];

    /// PageViewのインデックス
    final pageIndex = ref.watch(pageIndexProvider.state);

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
          if (pageIndex.state < index) {
            targetDate.state = targetDate.state.add(const Duration(days: 1));
          } else {
            targetDate.state = targetDate.state.add(const Duration(days: -1));
          }

          pageIndex.state = index;
        },
      ),
    );
  }

  scheduleCard({
    required BuildContext context,
    required Calendar cell,
    required void Function() onPressed,
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
                    onPressed: onPressed,
                  ),
                ],
              ),
            ),

            /// 予定がない
            if (cell.schedules.isEmpty) unscheduledCard(),

            /// 予定がある
            if (cell.schedules.isNotEmpty)

              /// 終日でない予定
              Column(
                children: cell.schedules
                    .where((schedule) => schedule.isAllDay)
                    .toList()
                    .map((e) => scheduleTile(e))
                    .toList(),
              ),

            /// 終日の予定
            Column(
              children: cell.schedules
                  .where((schedule) => !schedule.isAllDay)
                  .toList()
                  .map((e) => scheduleTile(e))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget scheduleTile(ScheduleData schedule) {
    final dateFormat = DateFormat('HH:mm');

    return Column(
      children: [
        const Divider(),
        InkWell(
          onTap: () {
            print("object");
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              children: [
                SizedBox(
                  width: 40,
                  child: schedule.isAllDay
                      ? Column(
                          children: [
                            Text(dateFormat.format(schedule.from)),
                            Text(dateFormat.format(schedule.to)),
                          ],
                        )
                      : const Center(child: Text("終日")),
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
      ],
    );
  }

  unscheduledCard() {
    return const Padding(
      padding: EdgeInsets.all(5.0),
      child: Center(
        child: Text("予定がありません"),
      ),
    );
  }
}
