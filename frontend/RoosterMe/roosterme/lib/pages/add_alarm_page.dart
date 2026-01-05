import 'package:flutter/material.dart';
import '../models/alarm_model.dart';

class AddAlarmPage extends StatefulWidget {
  const AddAlarmPage({super.key});

  @override
  State<AddAlarmPage> createState() => _AddAlarmPageState();
}

class _AddAlarmPageState extends State<AddAlarmPage> {
  TimeOfDay? selectedTime;
  final labelController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Alarm')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () async {
                final time = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                if (time != null) {
                  setState(() => selectedTime = time);
                }
              },
              child: Text(
                selectedTime == null
                    ? 'Select Time'
                    : selectedTime!.format(context),
              ),
            ),
            TextField(
              controller: labelController,
              decoration: const InputDecoration(labelText: 'Label'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: selectedTime == null
                  ? null
                  : () {
                      Navigator.pop(
                        context,
                        Alarm(
                          time: selectedTime!,
                          label: labelController.text,
                        ),
                      );
                    },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    labelController.dispose();
    super.dispose();
  }
}
