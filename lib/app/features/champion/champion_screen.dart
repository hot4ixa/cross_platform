import 'package:flutter/material.dart';
import 'widgets/quote_card.dart';
import 'widgets/story_block.dart';

class ChampionScreen extends StatelessWidget {
  const ChampionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // SliverAppBar
          SliverAppBar(
            pinned: true,
            expandedHeight: 260,
            leading: BackButton(),
            title: const Text("Home"),
            actions: const [Icon(Icons.menu)],
            flexibleSpace: FlexibleSpaceBar(
              background: _buildHeader(),
            ),
          ),

          // Контент
          SliverList(
            delegate: SliverChildListDelegate([
              const QuoteCard(),

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

  Widget _buildHeader() {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset("assets/images/test_image2.jpg", fit: BoxFit.cover),
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.transparent, Colors.black54, Colors.black87],
            ),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: const [
            Text("Чемпион",
                style: TextStyle(fontSize: 32, color: Colors.white)),
            Text("Титул",
                style: TextStyle(fontSize: 18, color: Colors.white70)),
            SizedBox(height: 16),
          ],
        ),
      ],
    );
  }
}
