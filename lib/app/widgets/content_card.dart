import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lab1/app/theme/theme_colors.dart';
import 'package:lab1/domain/domain.dart';

class ContentCard extends StatelessWidget {
  final Content content;
  final int index;
  const ContentCard({super.key, required this.content,  required this.index});

  @override
  Widget build(BuildContext context) {
    final imageSize = 200.0;

    final backgroundColor = index % 2 == 0
        ? ThemeColors.list_1
        : ThemeColors.list_2;

    return InkWell(
      onTap: () => {
        context.push('/champion/${content.id}'),
      },
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(200),
              offset: const Offset(0, 2),
              blurRadius: 10,
            ),
          ],
          border: Border(
            top: BorderSide(
              color: ThemeColors.orange.withAlpha(50),
              width: 0.5,
            ),
          ),
        ),

        height: imageSize,
        child: Row(
          spacing: 16,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              //borderRadius: BorderRadius.circular(10),
              child: Image.network(
                content.images.loading,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.error, color: Colors.white);
                },
              ),
            ),
            Expanded(
              child: Column(
                spacing: 5,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    content.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Expanded(
                    child: Text(
                      content.title,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
