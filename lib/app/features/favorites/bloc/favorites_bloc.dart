import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uniLOLverse/domain/domain.dart';
import 'package:uniLOLverse/di/di.dart';

import 'dart:async';
import 'package:equatable/equatable.dart';

part "favorites_event.dart";
part "favorites_state.dart";

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final ContentRepositoryInterface contentRepository;
  final UserDataServiceInterface userDataService;

  FavoritesBloc(this.userDataService, this.contentRepository) : super(FavoritesInitial()) {
    on<FavoritesLoad>(_favoritesLoad);
    on<FavoritesRemove>(_favoritesRemove);
  }

  Future<void> _favoritesRemove(FavoritesRemove event, Emitter<FavoritesState> emit) async {
    if (state is FavoritesLoadSuccess) {
      final currentState = state as FavoritesLoadSuccess;
      final updatedContent = List<Content>.from(currentState.content)
        ..removeWhere((c) => c.id == event.contentId);
      emit(FavoritesLoadSuccess(content: updatedContent));
    }
    
    try {
      await userDataService.removeFromFavorites(event.contentId);
      add(FavoritesLoad());
    } catch (e) {
      if (state is FavoritesLoadSuccess) {
        emit(state);
      }
    }
  }


  Future<void> _favoritesLoad(event, emit) async {
    try {
      if (state is !FavoritesLoadSuccess) {
        emit(FavoritesLoadInProgress());
      }
      final userData = await userDataService.getUserData();

      if (userData.favorites.isEmpty) {
        emit(FavoritesLoadSuccess(content: []));
        return;
      }

      final content = await contentRepository.getContentByIds(userData.favorites);
      emit(FavoritesLoadSuccess(content: content));
    } catch (exception, state) {
      final errorMessage = exception.toString();

      if (errorMessage.contains('User data not found') || 
          errorMessage.contains('not authenticated')) {
        emit(FavoritesLoadSuccess(content: []));
      }
      else{
        emit(FavoritesLoadFailure(exception: exception));
        talker.handle(exception, state);
      }
    }
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    talker.handle(error, stackTrace);
  }
}
