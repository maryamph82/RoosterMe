import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:flutter/material.dart';
import '../pages/challenges_page.dart';




class AlarmNotificationService {
  static final _notifications = FlutterLocalNotificationsPlugin();
  static late GlobalKey<NavigatorState> _navigatorKey;

   static Future<void> init(GlobalKey<NavigatorState> navigatorKey) async {

    _navigatorKey = navigatorKey;

    const androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const initSettings = InitializationSettings(
      android: androidSettings,
    );

    await _notifications.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (response) {
        final payload = response.payload;

        if (payload != null) {
          final alarmId = int.parse(payload);

          _navigatorKey.currentState?.push(
            MaterialPageRoute(
              builder: (_) => ChallengesPage(
                userData: const {}, // فعلاً خالی
                alarmId: alarmId,
              ),
            ),
          );
        }
      },
    );
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
      payload: id.toString(),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  // ✅ اضافه کردن این متد
  static Future<void> stopAlarm(int id) async {
    await _notifications.cancel(id);
  }
}
