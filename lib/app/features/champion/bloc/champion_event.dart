part of "champion_bloc.dart";

sealed class ChampionEvent {
  const ChampionEvent();
}

class ChampionLoad extends ChampionEvent {
  final String id;
  ChampionLoad({
    required this.id
  });
}

