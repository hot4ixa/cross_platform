import 'package:talker_dio_logger/talker_dio_logger.dart';
import 'package:lab1/di/di.dart';

void setUpDio() {
  dio.options.baseUrl = 'http://localhost:3000'; // общая часть адресов запросов
  // dio.options.queryParameters.addAll({
  //   'X-API-Key': 'GOAT_API_KEY', // ключ/токен, выданный при регистрации
  // });
  dio.options.headers.addAll({
    'X-API-Key': 'GOAT_API_KEY', // ключ/токен, выданный при регистрации
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
