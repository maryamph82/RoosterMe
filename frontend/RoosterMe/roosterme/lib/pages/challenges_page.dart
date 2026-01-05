import 'package:flutter/material.dart';
class ChallengesPage extends StatelessWidget {
  final Map<String, dynamic> data;

  const ChallengesPage(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    final challenges = data['challenges'];

    return ListView.builder(
      itemCount: challenges.length,
      itemBuilder: (_, i) {
        return CheckboxListTile(
          title: Text(challenges[i]['title']),
          value: challenges[i]['is_completed'],
          onChanged: (_) {},
        );
      },
    );
  }
}
