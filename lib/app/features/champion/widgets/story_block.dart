import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:lab1/app/theme/theme.dart';

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
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            title,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
        
        Padding(
          padding: const EdgeInsets.all(16),
          child: Html( 
            data: text, 
            style: {
              "body": Style(fontSize: FontSize(16), textAlign: TextAlign.center),
            },
          )
          
        ),
        const Divider(
          color: ThemeColors.brown,
          thickness: 0.4,
        ),
      ],
    );
  }
}
