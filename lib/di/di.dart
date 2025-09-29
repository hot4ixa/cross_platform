import 'package:talker_flutter/talker_flutter.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;
final talker = TalkerFlutter.init();

Future<void> setupLocator() async {
  getIt.registerSingleton(talker);
}
