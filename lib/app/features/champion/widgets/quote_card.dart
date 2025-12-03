import 'package:flutter/material.dart';
import 'package:lab1/app/theme/theme_colors.dart';

class QuoteCard extends StatelessWidget {
  final String quote;
  final String author;
  final String image;

  const QuoteCard({
    super.key,
    required this.quote,
    required this.author,
    required this.image,
  });

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
              Image.network( image ),

              Text(
                quote,
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),

              SizedBox(height: 10),

              Text(
                "~ $author",
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
