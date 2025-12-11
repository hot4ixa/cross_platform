import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uniLOLverse/domain/domain.dart';
import 'package:uniLOLverse/di/di.dart';

import 'dart:async';

part "champion_event.dart";
part "champion_state.dart";

class ChampionBloc extends Bloc<ChampionEvent, ChampionState> {
  final ContentRepositoryInterface contentRepository;

  ChampionBloc(this.contentRepository) : super(ChampionInitial()) {
    on<ChampionLoad>(_championLoad);
  }

  Future<void> _championLoad(event, emit) async {
    try {
      if (state is !ChampionLoadSuccess) {
        emit(ChampionLoadInProgress());
      }
      final champion = await contentRepository.getChampion(event.id);
      emit(ChampionLoadSuccess(champion: champion));
    } catch (exception, state) {
      emit(ChampionLoadFailure(exception: exception));
      talker.handle(exception, state);
    } finally {
      event.completer?.complete();
    }
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    talker.handle(error, stackTrace);
  }
}