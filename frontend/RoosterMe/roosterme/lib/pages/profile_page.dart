import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  final Map<String, dynamic> data;

  const ProfilePage(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Welcome ${data['user']['username']}',
        style: const TextStyle(fontSize: 22),
      ),
    );
  }
}
