import 'package:flutter/material.dart';
import '../models/alarm_model.dart';
import '../services/alarm_service.dart';
import '../services/alarm_notification_service.dart';
import 'add_alarm_page.dart';

class ActiveAlarmPage extends StatefulWidget {
  final Map<String, dynamic> userData;

  const ActiveAlarmPage(this.userData, {super.key});

  @override
  State<ActiveAlarmPage> createState() => _ActiveAlarmPageState();
}

class _ActiveAlarmPageState extends State<ActiveAlarmPage> {
  List<Alarm> alarms = [];

  @override
  void initState() {
    super.initState();
    _loadAlarms();
  }

  Future<void> _loadAlarms() async {
    final data = await AlarmService().loadAlarms();
    setState(() => alarms = data);
  }

  Future<void> _addAlarm() async {
    final newAlarm = await Navigator.push<Alarm>(
      context,
      MaterialPageRoute(builder: (_) => const AddAlarmPage()),
    );

    if (newAlarm != null) {
      setState(() {
        alarms.add(newAlarm);
      });

      // ⏰ فعلاً تستی: آلارم ۱ دقیقه بعد
      final now = DateTime.now();
      final alarmTime = DateTime(
        now.year,
        now.month,
        now.day,
        newAlarm.time.hour,
        newAlarm.time.minute,
      );

      await AlarmNotificationService.scheduleAlarm(
        id: alarmTime.millisecondsSinceEpoch ~/ 1000,
        time: alarmTime,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Alarms')),

      body: alarms.isEmpty
          ? const Center(child: Text('No alarms yet ⏰'))
          : ListView.builder(
              itemCount: alarms.length,
              itemBuilder: (_, index) {
                final alarm = alarms[index];
                return Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: ListTile(
                    leading: Switch(
                      value: alarm.isActive,
                      onChanged: (val) {
                        setState(() => alarm.isActive = val);
                      },
                    ),
                    title: Text(
                      alarm.time.format(context),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(alarm.label),
                  ),
                );
              },
            ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepOrange,
        onPressed: _addAlarm,
        child: const Icon(Icons.add),
      ),
    );
  }
}
