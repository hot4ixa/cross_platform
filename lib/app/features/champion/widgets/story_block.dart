import 'package:flutter/material.dart';

class StoryBlock extends StatelessWidget {
  final String title;
  final String text;

  const StoryBlock({
    super.key,
    required this.title,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            title,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(text, style: const TextStyle(fontSize: 16)),
        ),
        const Divider(),
      ],
    );
  }
}
