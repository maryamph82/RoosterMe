import 'dart:math';
import 'package:flutter/material.dart';
import '../services/alarm_notification_service.dart';

class ChallengesPage extends StatefulWidget {
  final Map<String, dynamic> userData;
  final int alarmId;

  const ChallengesPage({
    super.key,
    required this.userData,
    required this.alarmId,
  });

  @override
  State<ChallengesPage> createState() => _ChallengesPageState();
}

class _ChallengesPageState extends State<ChallengesPage> {
  final List<_MathQuestion> questions = [];
  final Map<int, TextEditingController> controllers = {};
  int correctAnswers = 0;

  @override
  void initState() {
    super.initState();
    _generateQuestions();
  }

  // تولید سوالات ریاضی تصادفی
  void _generateQuestions() {
    final rand = Random();
    for (int i = 0; i < 5; i++) {
      final a = rand.nextInt(20) + 1;
      final b = rand.nextInt(20) + 1;
      questions.add(_MathQuestion(a, b));
      controllers[i] = TextEditingController();
    }
  }

  // بررسی جواب‌ها و محاسبه تعداد درست‌ها
  void _submit() {
    correctAnswers = 0;

    for (int i = 0; i < questions.length; i++) {
      final userAnswer = int.tryParse(controllers[i]!.text);
      if (userAnswer == questions[i].answer) {
        correctAnswers++;
      }
    }

    if (correctAnswers >= 3) {
      _showResult(
        success: true,
        message: '🎉 موفق شدی! آلارم خاموش شد',
      );
    } else {
      _showResult(
        success: false,
        message: '❌ فقط $correctAnswers جواب درست بود. دوباره تلاش کن',
      );
    }
  }

  // نمایش نتیجه چالش
  void _showResult({required bool success, required String message}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: Text(success ? 'Success' : 'Try Again'),
        content: Text(message),
        actions: [
          if (!success)
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _reset();
              },
              child: const Text('Retry'),
            ),
          if (success)
            TextButton(
              onPressed: () async {
                // 🔹 خاموش کردن آلارم فقط در صورت موفقیت
                await AlarmNotificationService.stopAlarm(widget.alarmId);

                if (!mounted) return;
                Navigator.pop(context); // بستن دیالوگ
                Navigator.pop(context); // بستن صفحه چالش
              },
              child: const Text('OK'),
            ),
        ],
      ),
    );
  }

  // ریست کردن سوالات و کنترلرها
  void _reset() {
    for (final c in controllers.values) {
      c.clear();
    }
    questions.clear();
    controllers.clear();
    _generateQuestions();
    setState(() {});
  }

  @override
  void dispose() {
    for (final c in controllers.values) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Math Challenge'),
        backgroundColor: Colors.deepOrange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text(
              'Solve at least 3 of 5 to stop the alarm ⏰',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: questions.length,
                itemBuilder: (_, index) {
                  final q = questions[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: ListTile(
                      title: Text('${q.a} + ${q.b} = ?'),
                      trailing: SizedBox(
                        width: 80,
                        child: TextField(
                          controller: controllers[index],
                          keyboardType: TextInputType.number,
                          decoration:
                              const InputDecoration(hintText: '?'),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: _submit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text(
                  'Submit Answers',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// مدل سوال ریاضی
class _MathQuestion {
  final int a;
  final int b;

  _MathQuestion(this.a, this.b);

  int get answer => a + b;
}
