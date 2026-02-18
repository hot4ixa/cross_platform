import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:uniLOLverse/app/theme/theme_colors.dart';
import 'package:uniLOLverse/domain/domain.dart';

class ContentCard extends StatelessWidget {
  final Content content;
  final int index;
  final bool isAuthorized;
  final bool isFavorite;
  final VoidCallback? onToggleFavorite;

  const ContentCard({
    super.key,
    required this.content,
    required this.index,
    required this.isAuthorized,
    this.isFavorite = false,
    this.onToggleFavorite,
  });

  @override
  Widget build(BuildContext context) {
    final imageSize = 150.0;

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
        child: Stack(
          children: [ 
            Row(
              spacing: 16,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  child: Image.network(
                    content.images.loading,
                    fit: BoxFit.cover,

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
            if (isAuthorized)
              Positioned(
                top: 8,
                right: 8,
                child: GestureDetector(
                  onTap: () {
                    if (onToggleFavorite != null) {
                      onToggleFavorite!();
                      

                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              isFavorite
                                  ? 'Удалено из избранного' 
                                  : 'Добавлено в избранное',
                              style: const TextStyle(color: Colors.white),
                            ),
                            backgroundColor: isFavorite 
                                ? Colors.red.withAlpha(200) 
                                : Colors.pink.withAlpha(200),
                            duration: const Duration(milliseconds: 800),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      }
                    }
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: isFavorite 
                          ? Colors.red.withAlpha(100) 
                          : Colors.grey.withAlpha(100),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite ? Colors.red : Colors.grey,
                      size: 20,
                    ),
                  ),
                ),
              ),
          ]
        ),
      ),
    );
  }
}
