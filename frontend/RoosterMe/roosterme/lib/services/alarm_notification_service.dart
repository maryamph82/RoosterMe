import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class AlarmNotificationService {
  static final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    const androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const initSettings = InitializationSettings(
      android: androidSettings,
    );

    await _notifications.initialize(initSettings);
  }

  static Future<void> scheduleAlarm({
    required int id,
    required DateTime time,
  }) async {
    await _notifications.zonedSchedule(
      id,
      '⏰ RoosterMe Alarm',
      'Solve the challenge to stop alarm!',
      tz.TZDateTime.from(time, tz.local),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'alarm_channel',
          'Alarms',
          importance: Importance.max,
          priority: Priority.high,
          fullScreenIntent: true,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  static Future<void> stopAlarm(int id) async {
    await _notifications.cancel(id);
  }
}
