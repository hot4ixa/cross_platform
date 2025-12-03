import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:lab1/app/theme/theme.dart';

import 'package:lab1/app/widgets/widgets.dart';
import 'widgets/widgets.dart';
import 'package:lab1/di/di.dart';
import 'bloc/bloc.dart';



class ChampionPage extends StatefulWidget {
  final String id;

  const ChampionPage({
    super.key,
    required this.id 
  });

  @override
  State<ChampionPage> createState() => _ChampionPageState();
}

class _ChampionPageState extends State<ChampionPage> {
  final _champion = getIt<ChampionBloc>();
  void loadChampion() => _champion.add(ChampionLoad(id: widget.id));

  @override
  void initState() {
    loadChampion();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
                  color: Colors.white,
                  onPressed: () {
                  context.go("/home");
                  },
                ),
        title: Text('L E A G U E   O F   U N I V E R S E')
        ),
      body: BlocBuilder<ChampionBloc, ChampionState>(
        bloc: _champion,
        builder: (context, state) {
          return switch (state) {
            ChampionInitial() => _buildChampionInitial(),
            ChampionLoadInProgress() => _buildChampionLoadInProgress(),
            ChampionLoadSuccess() => _buildChampionLoadSuccess(state),
            ChampionLoadFailure() => _buildChampionLoadFailure(state),
          };
        }
      )
    );
  }

  Widget _buildChampionInitial() => SizedBox.shrink();

  Widget _buildChampionLoadInProgress() => AppProgressIndicator();

  Widget _buildChampionLoadFailure(ChampionLoadFailure state) {
    return AppError(
      description: state.exception.toString(),
      onTap: () => loadChampion(),
    );
  }

  Widget _buildChampionLoadSuccess(ChampionLoadSuccess state) {
    final content = state.champion;
    String quoteAuthor = content.name;
    if (content.quoteAuthor!.isNotEmpty) {
      quoteAuthor = content.quoteAuthor!;
    }

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate([

              Stack(
                children: [
                  Image.network(
                    content.images.splash!,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),

                  // Затемнение
                  Positioned.fill(
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black54,
                            ThemeColors.black_2,
                          ],
                        ),
                      ),
                    ),
                  ),

                  Positioned(
                    bottom: 20,
                    left: 0,
                    right: 0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          content.name,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        Text(
                          content.title,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              QuoteCard(
                quote: content.quote!,
                author: quoteAuthor,
                image: content.images.square!

              ),

              const SizedBox(height: 12),

              IntroCard(
                intro: content.biography!.short!,
              ),

              const SizedBox(height: 12),

              StoryBlock(
                title: "",
                text: content.biography!.full!,
              ),
              
              if (content.biography!.custom!.content!.isNotEmpty)
                StoryBlock(
                  title: content.biography!.custom!.title!,
                  text: content.biography!.custom!.content!,
                ),

              const SizedBox(height: 50),
            ]),
          )
        ],
      ),
    );
  }

}