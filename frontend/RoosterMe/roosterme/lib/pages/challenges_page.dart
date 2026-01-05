import 'dart:math';
import 'package:flutter/material.dart';

class ChallengesPage extends StatefulWidget {
  final Map<String, dynamic> userData;

  const ChallengesPage(this.userData, {super.key});

  @override
  State<ChallengesPage> createState() => _ChallengesPageState();
}

class _ChallengesPageState extends State<ChallengesPage> {
  final List<_MathQuestion> questions = [];
  final Map<int, TextEditingController> controllers = {};
  int correctAnswers = 0;
  bool submitted = false;

  @override
  void initState() {
    super.initState();
    _generateQuestions();
  }

  void _generateQuestions() {
    final rand = Random();
    for (int i = 0; i < 5; i++) {
      final a = rand.nextInt(20) + 1;
      final b = rand.nextInt(20) + 1;
      questions.add(_MathQuestion(a, b));
      controllers[i] = TextEditingController();
    }
  }

  void _submit() {
    correctAnswers = 0;

    for (int i = 0; i < questions.length; i++) {
      final userAnswer = int.tryParse(controllers[i]!.text);
      if (userAnswer == questions[i].answer) {
        correctAnswers++;
      }
    }

    setState(() => submitted = true);

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
              onPressed: () {
                Navigator.pop(context);
                // اینجا بعداً آلارم رو خاموش می‌کنیم
              },
              child: const Text('OK'),
            ),
        ],
      ),
    );
  }

  void _reset() {
    questions.clear();
    controllers.clear();
    submitted = false;
    _generateQuestions();
    setState(() {});
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
                          decoration: const InputDecoration(
                            hintText: '?',
                          ),
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

class _MathQuestion {
  final int a;
  final int b;

  _MathQuestion(this.a, this.b);

  int get answer => a + b;
}
