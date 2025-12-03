import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'widgets/widgets.dart';

import 'package:lab1/app/theme/theme.dart';

class ChampionScreen extends StatelessWidget {
  final String id;

  const ChampionScreen({
    super.key,
    required this.id
    });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // AppBar
          SliverAppBar(
            leading: BackButton(
              color: Colors.white,
              onPressed: () {
                context.pop();
              },
            ),
            pinned: true,
            title: const Text("L E A G U E   O F   U N I V E R S E"),
          ),

          SliverList(
            delegate: SliverChildListDelegate([

              Stack(
                children: [
                  Image.asset(
                    "assets/images/test_image2.jpg",
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
                          "Чемпион",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        Text(
                          "Титул",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              // const QuoteCard(),

              // const SizedBox(height: 12),

              // const IntroCard(),

              const SizedBox(height: 12),

              const StoryBlock(
                title: "Название истории 1",
                text: "Большой текст истории...",
              ),
              
              const StoryBlock(
                title: "Название истории 2",
                text: "Большой текст истории...",
              ),

              const SizedBox(height: 50),
            ]),
          )
        ],
      ),
    );
  }
}
