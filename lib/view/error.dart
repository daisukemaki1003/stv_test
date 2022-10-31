import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RouteErrorPage extends StatelessWidget {
  final String errorMsg;
  const RouteErrorPage({super.key, required this.errorMsg});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("No route"),
      ),
      body: Center(
        child: Text(errorMsg),
      ),
    );
  }
}
