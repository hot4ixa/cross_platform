part of "champion_bloc.dart";

sealed class ChampionState {
  const ChampionState();
}

final class ChampionInitial extends ChampionState {}

final class ChampionLoadInProgress extends ChampionState {}

class ChampionLoadSuccess extends ChampionState {
  final Content champion;

  const ChampionLoadSuccess({
    required this.champion
  });
}

class ChampionLoadFailure extends ChampionState {
  const ChampionLoadFailure({ 
    required this.exception
  });

  final Object? exception;
}
