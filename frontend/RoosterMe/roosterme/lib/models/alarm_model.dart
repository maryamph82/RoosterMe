import 'package:flutter/material.dart';

class Alarm {
  final TimeOfDay time;
  final String label;
  bool isActive;

  Alarm({
    required this.time,
    required this.label,
    this.isActive = true,
  });

  factory Alarm.fromJson(Map<String, dynamic> json) {
    final parts = json['alarm_time'].split(':');

    return Alarm(
      time: TimeOfDay(
        hour: int.parse(parts[0]),
        minute: int.parse(parts[1]),
      ),
      label: json['label'] ?? 'Alarm',
      isActive: json['is_active'] ?? true,
    );
  }
}
