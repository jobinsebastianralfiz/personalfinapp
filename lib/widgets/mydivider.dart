import 'package:flutter/material.dart';

class MyDivider extends StatelessWidget {
  const MyDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0,top: 16),
      child: Divider(
        height: 1.3,
        color: Colors.deepOrange
      ),
    );
  }
}
