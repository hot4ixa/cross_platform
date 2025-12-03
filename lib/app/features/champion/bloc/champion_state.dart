part of "champion_bloc.dart";

sealed class ChampionState extends Equatable{
  const ChampionState();

  @override
  List<Object> get props => [];
}

final class ChampionInitial extends ChampionState {}

final class ChampionLoadInProgress extends ChampionState {}

class ChampionLoadSuccess extends ChampionState {
  final Content champion;

  const ChampionLoadSuccess({ required this.champion });

  @override
  List<Object> get props => [champion];
}

class ChampionLoadFailure extends ChampionState {
  const ChampionLoadFailure({ required this.exception });

  final Object? exception;

  @override
  List<Object> get props => [];
}