part of "favorites_bloc.dart";

sealed class FavoritesEvent extends Equatable {
  const FavoritesEvent();

  @override
  List<Object> get props => [];
}

class FavoritesLoad extends FavoritesEvent {
  const FavoritesLoad({this.completer});

  final Completer? completer;

  @override
  List<Object> get props => [];
}

class FavoritesRemove extends FavoritesEvent {
  final String contentId;
  const FavoritesRemove(this.contentId);
  @override
  List<Object> get props => [contentId];
}