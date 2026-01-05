import 'package:flutter/material.dart';
import '../services/alarm_service.dart';
import '../models/alarm_model.dart';

class ActiveAlarmPage extends StatelessWidget {
  final Map<String, dynamic> data;

  const ActiveAlarmPage(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    final alarms = data['alarms'];

    return ListView.builder(
      itemCount: alarms.length,
      itemBuilder: (_, i) {
        return ListTile(
          title: Text(alarms[i]['alarm_time']),
        );
      },
    );
  }
}

