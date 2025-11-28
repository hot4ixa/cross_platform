import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:lab1/app/widgets/widgets.dart';
import 'package:lab1/di/di.dart';
import 'bloc/bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _homeBloc = getIt<HomeBloc>();

  @override
  void initState() {
    super.initState();
    _homeBloc.add(HomeLoad());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('L E A G U E   O F   U N I V E R S E')),
      body: BlocBuilder<HomeBloc, HomeState>(
        bloc: _homeBloc,
        builder: (context, state) {
          return Column(
            children: [
              _buildHeader(context),
              Expanded(child: _buildContent(state)),
            ],
          );
        },
      ),
    );
  }

  
  Widget _buildHeader(BuildContext context) {
    return Container(
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
          'Header',
          style: Theme.of(context).textTheme.labelLarge,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildContent(HomeState state) {
    if (state is HomeLoadInProgress || state is HomeInitial) {
      return Center(child: CircularProgressIndicator());
    }

    if (state is HomeLoadFailure) {
      return Center(
        child: TextButton(
          onPressed: () => _homeBloc.add(HomeLoad()),
          child: Text('Ошибка. Попробовать снова'),
        ),
      );
    }

    if (state is HomeLoadSuccess) {
      final content = state.content;

      return ListView.separated(
        padding: EdgeInsets.all(16),
        itemCount: content.length,
        itemBuilder: (_, index) =>
            ContentCard(content: content[index], index: index),
        separatorBuilder: (_, __) => SizedBox(height: 16),
      );
    }

    return SizedBox.shrink();
  }
}
