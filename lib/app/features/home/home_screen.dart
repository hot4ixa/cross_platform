import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:uniLOLverse/app/widgets/widgets.dart';
import 'package:uniLOLverse/di/di.dart';
import 'bloc/bloc.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _home = getIt<HomeBloc>();
  void loadHome() => _home.add(HomeLoad());

  @override
  void initState() {
    _home.add(HomeLoad());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeBloc>().add(const HomeLoad());
    });

    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, authSnapshot) {
        final isAuthorized = authSnapshot.hasData && authSnapshot.data != null;

        return Scaffold(
          appBar: CustomAppBar(
            pageId: PageId.home,
            context: context,
            isAuthorized: isAuthorized,
          ),
          body: BlocBuilder<HomeBloc, HomeState>(
            bloc: _home,
            builder: (context, state) {
              return switch (state) {
                HomeInitial() => _buildHomeInitial(),
                HomeLoadInProgress() => _buildHomeLoadInProgress(),
                HomeLoadFailure() => _buildHomeLoadFailure(state),
                HomeLoadSuccess() => _buildHomeLoadSuccess(state, isAuthorized),
              };
            },
          ),
        );
      },
    );
  }

  Widget _buildHomeInitial() => SizedBox.shrink();

  Widget _buildHomeLoadInProgress() => AppProgressIndicator();

  Widget _buildHomeLoadFailure(HomeLoadFailure state) {
    return AppError(
      description: state.exception.toString(),
      onTap: () => loadHome(),
    );
  }

  Widget _buildHomeLoadSuccess(HomeLoadSuccess state, bool isAuthorized) {
    final content = state.content;
    final favoriteIds = state.favoriteIds;
  
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
            (context, index) {
              final item = content[index];
              final isFavorite = favoriteIds.contains(item.id);

              return ContentCard(
                content: content[index],
                index: index,
                isAuthorized: isAuthorized,
                isFavorite: isFavorite,
                onToggleFavorite: isAuthorized
                        ? () {
                          _home.add(
                            HomeToggleFavorite(
                              contentId: item.id,
                              isCurrentlyFavorite: isFavorite,
                            ),
                          );}
                        : null
              );
            },
            childCount: content.length,
          ),
        ),
      ],
    );

  }
}
