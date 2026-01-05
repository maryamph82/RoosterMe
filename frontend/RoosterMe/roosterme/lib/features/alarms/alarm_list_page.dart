import 'package:flutter/material.dart';
import 'add_alarm_page.dart';

class AlarmListPage extends StatelessWidget {
  const AlarmListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("RoosterMe")),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => AddAlarmPage(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          _AlarmCard(time: "06:30", label: "Wake Up", active: true),
          _AlarmCard(time: "08:00", label: "Weekend", active: false),
        ],
      ),
    );
  }
}

class _AlarmCard extends StatelessWidget {
  final String time;
  final String label;
  final bool active;

  const _AlarmCard({
    required this.time,
    required this.label,
    required this.active,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        title: Text(
          time,
          style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(label),
        trailing: Switch(value: active, onChanged: (_) {}),
      ),
    );
  }
}
