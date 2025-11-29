import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:talker_flutter/talker_flutter.dart';

import 'package:lab1/app/features/features.dart';
import 'package:lab1/di/di.dart';

final _rootNavigationKey = GlobalKey<NavigatorState>(debugLabel: 'root');

final router = GoRouter(
  observers: [TalkerRouteObserver(talker)],
  debugLogDiagnostics: true,
  initialLocation: '/home',
  navigatorKey: _rootNavigationKey,
  routes: [
    GoRoute(
      path: '/home',
      pageBuilder: (_, state) => MaterialPage(
        key: state.pageKey,
        child: const HomeScreen(),
      ),
    ),

    GoRoute(
      path: '/champion/:id',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return ChampionPage(id: id);
      },
    ),

    // для следующей лабораторной работы
    // GoRoute(
    //   path: '/content/:id',
    //   pageBuilder: (_, state) => MaterialPage(
    //     key: state.pageKey,
    //     child: ContentScreen(contentId: state.pathParameters['id']!),
    //   ),
    // ),
  ],
);
