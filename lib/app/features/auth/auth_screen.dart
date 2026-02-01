import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:uniLOLverse/app/widgets/widgets.dart';
import 'package:uniLOLverse/di/di.dart';
import 'bloc/bloc.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = getIt<AuthBloc>();
  void loadHome() => _auth.add(AuthLoad());

  @override
  void initState() {
    loadHome();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('L E A G U E   O F   U N I V E R S E')),
      body: BlocBuilder<AuthBloc, AuthState>(
        bloc: _auth,
        builder: (context, state) {
          return switch (state) {
            AuthInitial() => _buildAuthInitial(),
            AuthAuthInProgress() => _buildAuthLoadInProgress(),
            AuthAuthSuccess() => _buildAuthLoadSuccess(state),
            AuthAuthFailure() => _buildAuthLoadFailure(state),
          };
        },
      ),
    );
  }

  
  Widget _buildAuthInitial() => SizedBox.shrink();

  Widget _buildAuthLoadInProgress() => AppProgressIndicator();

  Widget _buildAuthLoadFailure(AuthLoadFailure state) {
    return AppError(
      description: state.exception.toString(),
      onTap: () => loadAuth(),
    );
  }

  Widget _buildAuthLoadSuccess(AuthLoadSuccess state) {
    final content = state.content;
  
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/championsBackground.jpg'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black.withAlpha(180),
                  BlendMode.darken,
                ),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
              child: Text(
                'Чемпионы',
                style: Theme.of(context).textTheme.labelLarge,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => ContentCard(content: content[index], index: index),
            childCount: content.length,
          ),
        ),
      ],
    );

  }
}
