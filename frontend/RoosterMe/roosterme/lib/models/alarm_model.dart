class Alarm {
  final int alarmId;
  final String alarmTime;
  final bool isActive;

  Alarm({
    required this.alarmId,
    required this.alarmTime,
    required this.isActive,
  });

  factory Alarm.fromJson(Map<String, dynamic> json) {
    return Alarm(
      alarmId: json['alarm_id'],
      alarmTime: json['alarm_time'],
      isActive: json['is_active'],
    );
  }
}
