import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:uniLOLverse/app/widgets/widgets.dart';
import 'package:uniLOLverse/di/di.dart';
import 'bloc/bloc.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  final _favorites = getIt<FavoritesBloc>();
  void loadFavorites() => _favorites.add(FavoritesLoad());

  @override
  void initState() {
    loadFavorites();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: CustomAppBar(pageId: PageId.favorites, context: context, isAuthorized: true),
      body: BlocBuilder<FavoritesBloc, FavoritesState>(
        bloc: _favorites,
        builder: (context, state) {
          return switch (state) {
            FavoritesInitial() => _buildFavoritesInitial(),
            FavoritesLoadInProgress() => _buildFavoritesLoadInProgress(),
            FavoritesLoadSuccess() => _buildFavoritesLoadSuccess(state),
            FavoritesLoadFailure() => _buildFavoritesLoadFailure(state),
          };
        },
      ),
    );
  }

  Widget _buildFavoritesInitial() => SizedBox.shrink();

  Widget _buildFavoritesLoadInProgress() => AppProgressIndicator();

  Widget _buildFavoritesLoadFailure(FavoritesLoadFailure state) {
    return AppError(
      description: state.exception.toString(),
      onTap: () => loadFavorites(),
    );
  }

  Widget _buildFavoritesLoadSuccess(FavoritesLoadSuccess state) {
    final content = state.content;

    final Widget header = Container(
            width: double.infinity,
            height: 200,
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
                'Избранное',
                style: Theme.of(context).textTheme.labelLarge,
                textAlign: TextAlign.center,
              ),
            ),
          );

    if (content.isEmpty) {
      return CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: header,
          ),
        ],
      );
    }

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
            child: header,
          ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return ContentCard(
                content: content[index],
                index: index,
                isAuthorized: true,
                isFavorite: true,
                onToggleFavorite: () {
                  _favorites.add(FavoritesRemove(content[index].id));
                },
              );
            },
            childCount: content.length,
          ),
        ),
      ],
    );

  }
}
