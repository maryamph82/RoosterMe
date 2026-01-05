import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/alarm_model.dart';

class AlarmService {
  Future<List<Alarm>> loadAlarms() async {
    final jsonString =
        await rootBundle.loadString('assets/data/active_alarms.json');

    final List data = jsonDecode(jsonString);

    return data.map((e) => Alarm.fromJson(e)).toList();
  }
}
