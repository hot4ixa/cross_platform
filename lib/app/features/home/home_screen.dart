import 'package:flutter/material.dart';
import '../../widgets/content_card.dart';
import '../../extensions/widget_extensions.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('L E A G U E   O F   U N I V E R S E')),
      body: SingleChildScrollView(
        //padding: EdgeInsets.all(16),
        child: Column(
          spacing: 0,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
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
                padding: const EdgeInsets.symmetric(
                  vertical: 40,
                  horizontal: 24,
                ),
                child: Text(
                  'Header',
                  style: Theme.of(context).textTheme.labelLarge,
                  textAlign: TextAlign.center,
                ),
              ),
            ),

            ListView.separated(
              //padding: EdgeInsets.symmetric(horizontal: 16),
              primary: false,
              shrinkWrap: true,
              itemCount: 10,
              itemBuilder: (_, index) => ContentCard(index:index),
              separatorBuilder: (_, __) => 0.ph,
            ),
          ],
        ),
      ),
    );
  }
}
