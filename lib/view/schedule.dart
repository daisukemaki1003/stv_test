import 'package:flutter/material.dart';

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
          scheduleCard(),
          scheduleCard(),
          scheduleCard(),
          scheduleCard(),
          scheduleCard(),
          scheduleCard(),
          scheduleCard(),
        ],
      ),
    );
  }

  scheduleCard() {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Card(
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
                    onPressed: () {},
                    icon: const Icon(Icons.add),
                  ),
                ],
              ),
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}
