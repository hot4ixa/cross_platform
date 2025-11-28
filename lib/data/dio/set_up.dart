import 'package:talker_dio_logger/talker_dio_logger.dart';
import 'package:lab1/di/di.dart';

void setUpDio() {
  dio.options.baseUrl = 'localhost:3000'; // общая часть адресов запросов
  dio.options.queryParameters.addAll({
    'api_token': 'GOAT_API_KEY', // ключ/токен, выданный при регистрации
  });
  dio.options.connectTimeout = const Duration(seconds: 5);
  dio.options.receiveTimeout = const Duration(seconds: 5);
  dio.interceptors.addAll([
    TalkerDioLogger(
      talker: talker,
      settings: TalkerDioLoggerSettings(
        printRequestData: true,
        printRequestHeaders: true,
      ),
    ),
  ]);
}
