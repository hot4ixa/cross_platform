import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:go_router/go_router.dart';

import 'widgets/widgets.dart';

import 'package:lab1/app/theme/theme.dart';

// import 'champion_screen.dart';
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
  final _championBloc = getIt<ChampionBloc>();

  @override
  void initState() {
    super.initState();
    _championBloc.add(ChampionLoad(id: widget.id));
  }

  @override
  void dispose() {
    _championBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('L E A G U E   O F   U N I V E R S E')),
      body: BlocBuilder<ChampionBloc, ChampionState>(
        bloc: _championBloc,
        builder: (context, state) {
          return Column(
            children: [
              _buildHeader(context),
              Expanded(child: _buildContent(state)),
            ],
          );
        }
      )
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container();
  }

  Widget _buildContent(ChampionState state) {
    return Container();
  }
}