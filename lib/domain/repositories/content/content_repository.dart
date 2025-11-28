import 'package:dio/dio.dart';
import 'model/content.dart';
import 'package:lab1/data/endpoints.dart';
import 'content_repository_interface.dart';

class ContentRepository implements ContentRepositoryInterface {
  final Dio dio;

  ContentRepository({required this.dio});

  @override
  Future<List<Content>> getContent() async {
    try {
      final ur = dio.options.baseUrl;
      final Response response = await dio.get(Endpoints.content);
      final content = (response.data as List)
          .map((e) => Content.fromJson(e))
          .toList();
      return content;
    } on DioException catch (e) {
      throw e.message.toString();
    }
  }
}
