import 'package:flutter/material.dart';
import '../models/alarm_model.dart';
import '../services/alarm_service.dart';
import '../services/alarm_notification_service.dart';

class ActiveAlarmPage extends StatefulWidget {
  final Map<String, dynamic> userData;

  const ActiveAlarmPage(this.userData, {super.key});

  @override
  State<ActiveAlarmPage> createState() => _ActiveAlarmPageState();
}

class _ActiveAlarmPageState extends State<ActiveAlarmPage> {
  late Future<List<Alarm>> alarmsFuture;

  @override
  void initState() {
    super.initState();
    alarmsFuture = AlarmService().loadAlarms();
  }

  @override
  Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('Alarms')),
    body: FutureBuilder<List<Alarm>>(
      future: alarmsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text(snapshot.error.toString()));
        }

        final alarms = snapshot.data!;

        return ListView.builder(
          itemCount: alarms.length,
          itemBuilder: (_, index) {
            final alarm = alarms[index];
            return ListTile(
              leading: Switch(
                value: alarm.isActive,
                onChanged: (val) {
                  setState(() => alarm.isActive = val);
                },
              ),
              title: Text(alarm.time.format(context)),
              subtitle: Text(alarm.label),
            );
          },
        );
      },
    ),
    floatingActionButton: FloatingActionButton(
      onPressed: () {
        final alarmTime = DateTime.now().add(const Duration(minutes: 1));

        AlarmNotificationService.scheduleAlarm(
          id: DateTime.now().millisecondsSinceEpoch ~/ 1000,
          time: alarmTime,
        );
      },
      child: const Icon(Icons.alarm_add),
    ),
  );

  }

    
    
}
