part of "home_bloc.dart";

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

final class HomeInitial extends HomeState {}

final class HomeLoadInProgress extends HomeState {}

final class HomeLoadSuccess extends HomeState {
  final List<Content> content;
  final Set<String> favoriteIds;
  
  const HomeLoadSuccess({ required this.content, required this.favoriteIds});

  @override
  List<Object> get props => [content, favoriteIds];
}

final class HomeLoadFailure extends HomeState {
  const HomeLoadFailure({required this.exception});

  final Object? exception;

  @override
  List<Object> get props => [];
}

