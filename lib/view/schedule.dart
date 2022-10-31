import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:stv_test/repository/calendar/selector.dart';
import 'package:stv_test/routing/named_route.dart';

class SchedulePage extends ConsumerWidget {
  const SchedulePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /// 選択中の日付
    final targetDate = ref.watch(targetDateProvider.state);

    /// 表示するページ
    final pages = [
      scheduleCard(
        context: context,
        selectedDate: targetDate.state,
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
    required DateTime selectedDate,
    required void Function() onPressed,
  }) {
    /// 日付フォーマット
    final dateFormat = DateFormat('yyyy/M/d');
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
                    icon: const Icon(Icons.add),
                    onPressed: onPressed,
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
