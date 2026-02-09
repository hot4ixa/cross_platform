import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:uniLOLverse/app/features/features.dart';
import 'package:uniLOLverse/di/di.dart';

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
      pageBuilder: (context, state) {
        final id = state.pathParameters['id']!;
        return NoTransitionPage(
          key: state.pageKey,
          child: BlocProvider(
            create: (_) => getIt<ChampionBloc>()..add(ChampionLoad(id: id)),
            child: ChampionPage(id: id),
          ),
        );
      },
    ),

    GoRoute(
      path: '/auth',
      builder: (context, state) => BlocProvider(
        create: (context) => getIt.get<AuthBloc>(),
        child: const AuthScreen(),
      ),
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
