import 'package:flutter/material.dart';
import 'package:lab1/app/theme/theme_colors.dart';

class IntroCard extends StatelessWidget {
  const IntroCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(

        decoration: BoxDecoration(
          color: ThemeColors.quoteBackgroundColor,
          border: Border.all(
            color: ThemeColors.orange.withAlpha(50),
            width: 1,
          ),
        ),
        
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Text(
                "История",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}