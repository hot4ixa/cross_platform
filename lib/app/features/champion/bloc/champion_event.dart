part of "champion_bloc.dart";

sealed class ChampionEvent extends Equatable {
  const ChampionEvent();

    @override
  List<Object> get props => [];
}

class ChampionLoad extends ChampionEvent {
  final String id;
  ChampionLoad({
    this.completer,
    required this.id
  });

  final Completer? completer;
  
  @override
  List<Object> get props => [];
}
