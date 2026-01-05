import 'package:flutter/material.dart';

class AddAlarmPage extends StatelessWidget {
  const AddAlarmPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Alarm")),
      body: Center(
        child: Text(
          "Add Alarm Form (MVP)",
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
    );
  }
}
