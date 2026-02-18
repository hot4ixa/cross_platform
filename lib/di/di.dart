import 'package:talker_flutter/talker_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';

import 'package:uniLOLverse/domain/domain.dart';
import 'package:uniLOLverse/domain/repositories/content/content_repository.dart';

import 'package:uniLOLverse/domain/repositories/auth/auth_service.dart';
import 'package:uniLOLverse/data/dio/dio.dart';
import 'package:uniLOLverse/domain/repositories/user_data/user_data_service.dart';
import 'package:uniLOLverse/app/features/favorites/bloc/bloc.dart';

import 'package:uniLOLverse/app/features/features.dart';

final getIt = GetIt.instance;
final talker = TalkerFlutter.init();
final Dio dio = Dio();

Future<void> setupLocator() async {
  setUpDio();

  getIt.registerSingleton<ContentRepositoryInterface>(
    ContentRepository(dio: dio),
  );

  getIt.registerSingleton<UserDataServiceInterface>(
    UserDataService(),
  );

  getIt.registerSingleton<AuthServiceInterface>(
    AuthService(),
  );

  getIt.registerSingleton(talker);

  getIt.registerSingleton(HomeBloc(getIt.get<ContentRepositoryInterface>(), getIt.get<UserDataServiceInterface>()));
  getIt.registerFactory(() => ChampionBloc(getIt.get<ContentRepositoryInterface>()));
  getIt.registerFactory(() => AuthBloc(getIt.get<AuthServiceInterface>(), getIt.get<UserDataServiceInterface>()));
  getIt.registerLazySingleton<FavoritesBloc>(() => FavoritesBloc(
      getIt<UserDataServiceInterface>(),
      getIt<ContentRepositoryInterface>(),
    ));
}
