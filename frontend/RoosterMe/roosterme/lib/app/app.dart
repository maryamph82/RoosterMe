
import 'package:flutter/material.dart';
import 'theme.dart';
import '../features/alarms/alarm_list_page.dart';

class RoosterMeApp extends StatelessWidget {
  const RoosterMeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const AlarmListPage(),
    );
  }
}
