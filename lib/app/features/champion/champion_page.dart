import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:uniLOLverse/app/theme/theme.dart';

import 'package:uniLOLverse/app/widgets/widgets.dart';
import 'widgets/widgets.dart';
import 'package:uniLOLverse/di/di.dart';
import 'bloc/bloc.dart';



class ChampionPage extends StatelessWidget {
  final String id;

  const ChampionPage({
    super.key,
    required this.id 
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Colors.white,
          onPressed: () => context.go("/home"),
        ),
        title: Text('L E A G U E   O F   U N I V E R S E'),
      ),
      body: BlocBuilder<ChampionBloc, ChampionState>(
        builder: (context, state) {
          switch (state) {
            case ChampionInitial():
              return SizedBox.shrink();
            case ChampionLoadInProgress():
              return AppProgressIndicator();
            case ChampionLoadFailure():
              return AppError(
                description: state.exception.toString(),
                onTap: () => context.read<ChampionBloc>().add(
                      ChampionLoad(id: id),
                    ),
              );
            case ChampionLoadSuccess():
              return _buildChampionLoadSuccess(context, state);
          }
        },
      ),
    );
  }


  Widget _buildChampionLoadSuccess( BuildContext context, ChampionLoadSuccess state ) 
  {
  final content = state.champion;

  String quoteAuthor = content.quoteAuthor?.isNotEmpty == true
      ? content.quoteAuthor!
      : content.name;

  return CustomScrollView(
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
            image: content.images.square!,
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
        ),
      ],
    );
  }
  
}