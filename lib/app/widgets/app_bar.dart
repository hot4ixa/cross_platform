import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

enum PageId {
  home,
  champion,
  auth,
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final PageId pageId;
  final BuildContext context;

  const CustomAppBar({
    super.key,
    required this.pageId,
    required this.context,
  });

  @override
  Widget build(BuildContext context) {
    switch (pageId)
    {
      case PageId.home:
        return AppBar(
          title: Text('L E A G U E   O F   U N I V E R S E'),
          actions: [
            TextButton(
              onPressed: () => this.context.go("/auth"),
              style: TextButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 40, 40, 40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              ),
              child: const Text(
                'ВХОД',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  letterSpacing: 2.5,
                )
              ),
            ),
            const SizedBox(width: 16,),
          ],
        );
        
      case PageId.champion:
        return AppBar(
          leading: BackButton(
            color: Colors.white,
            onPressed: () => this.context.go("/home"),
          ),
          title: Text('L E A G U E   O F   U N I V E R S E'),
        );

      case PageId.auth:
        return AppBar(
            leading: BackButton(
            color: Colors.white,
            onPressed: () => this.context.go("/home"),
          ),
          title: Text('L E A G U E   O F   U N I V E R S E')
        );
    }
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}