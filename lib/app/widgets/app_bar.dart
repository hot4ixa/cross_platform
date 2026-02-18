import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';

enum PageId {
  home,
  champion,
  auth,
  favorites,
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final PageId pageId;
  final BuildContext context;
  final bool isAuthorized;

  const CustomAppBar({
    super.key,
    required this.pageId,
    required this.context,
    required this.isAuthorized,
  });

  Future<void> _signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Вы успешно вышли из аккаунта'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
          ),
        );
      }
      
      if (context.mounted) {
        context.go('/home');
      }
    } catch (e) {
      // Обработка ошибок при выходе
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Ошибка при выходе: $e'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    TextButton button;
    if (isAuthorized) {
      if ( pageId != PageId.favorites ) {
        button = TextButton(
          onPressed: () => this.context.go("/favorites"),
          style: TextButton.styleFrom(
            backgroundColor: Color.fromARGB(255, 40, 40, 40),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          ),
          child: const Text(
            'ПРОФИЛЬ',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
              letterSpacing: 2.5,
            )
          ),
        );
      }
      else
      {
        button = TextButton(
          onPressed: () => { this.context.go("/auth"), _signOut()},
          style: TextButton.styleFrom(
            backgroundColor: Color.fromARGB(255, 40, 40, 40),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          ),
          child: const Text(
            'ВЫЙТИ',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
              letterSpacing: 2.5,
            )
          ),
        );
      }
    } else {
      button = TextButton(
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
      );
    }
    
    BackButton backButton = BackButton(
            color: Colors.white,
            onPressed: () => this.context.go("/home"),
          );

    Text appTitle = Text('LEAGUE OF UNIVERSE');

    switch (pageId)
    {
      case PageId.home:
        return AppBar(
          title: appTitle,
          actions: [
            button,
            const SizedBox(width: 16,),
          ],
        );
        
      case PageId.champion:
        return AppBar(
          leading: backButton,
          title: appTitle,
          actions: [
            button,
            const SizedBox(width: 16,),
          ],
        );

      case PageId.auth:
        return AppBar(
            leading: backButton,
          title: appTitle
        );

      case PageId.favorites:
        return AppBar(
          leading: backButton,
          title: appTitle,
          actions: [
            button,
            const SizedBox(width: 16,),
          ],
        );
    }
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}