import 'package:talker_flutter/talker_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';

import 'package:lab1/domain/domain.dart';
import 'package:lab1/domain/repositories/content/content_repository.dart';
import 'package:lab1/data/dio/dio.dart';

import 'package:lab1/app/features/features.dart';

final getIt = GetIt.instance;
final talker = TalkerFlutter.init();
final Dio dio = Dio();

Future<void> setupLocator() async {
  setUpDio();
  getIt.registerSingleton<ContentRepositoryInterface>(
    ContentRepository(dio: dio),
  );
  getIt.registerSingleton(HomeBloc(getIt.get<ContentRepositoryInterface>()));
  getIt.registerSingleton(talker);
}
