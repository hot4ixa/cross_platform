import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uniLOLverse/domain/domain.dart';
import 'package:uniLOLverse/di/di.dart';

import 'dart:async';
import 'package:equatable/equatable.dart';

part "home_event.dart";
part "home_state.dart";

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final ContentRepositoryInterface contentRepository;
  final UserDataServiceInterface userDataService;

  HomeBloc(this.contentRepository, this.userDataService) : super(HomeInitial()) {
    on<HomeLoad>(_homeLoad);
    on<HomeToggleFavorite>(_onToggleFavorite);
  }

  Future<void> _homeLoad(event, emit) async {
    emit(HomeLoadInProgress());
    try {
      final content = await contentRepository.getContent();
      
      Set<String> favoriteIds = {};
      try {
        final userData = await userDataService.getUserData();
        favoriteIds = userData.favorites.toSet();
      } catch (e) {
        favoriteIds = {};
      }

      emit(HomeLoadSuccess(content: content, favoriteIds: favoriteIds));
    } catch (exception, state) {
      emit(HomeLoadFailure(exception: exception));
      talker.handle(exception, state);
    }
  }

  Future<void> _onToggleFavorite(HomeToggleFavorite event, Emitter<HomeState> emit) async {
    if (state is! HomeLoadSuccess) return;
    
    final currentState = state as HomeLoadSuccess;
    
    try {
      Set<String> updatedFavorites = Set.from(currentState.favoriteIds);
      
      if (event.isCurrentlyFavorite) {
        updatedFavorites.remove(event.contentId);
        await userDataService.removeFromFavorites(event.contentId);
      } else {
        updatedFavorites.add(event.contentId);
        await userDataService.addToFavorites(event.contentId);
      }
      
      emit(HomeLoadSuccess(
        content: currentState.content,
        favoriteIds: updatedFavorites,
      ));
    } catch (e) {
      // При ошибке возвращаем предыдущее состояние
      emit(HomeLoadSuccess(
        content: currentState.content,
        favoriteIds: currentState.favoriteIds,
      ));
      
      talker.handle(e, StackTrace.current);
    }
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    talker.handle(error, stackTrace);
  }
}
