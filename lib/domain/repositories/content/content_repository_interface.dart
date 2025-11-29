import 'model/content.dart';

abstract interface class ContentRepositoryInterface {
  Future<List<Content>> getContent();
  Future<Content> getChampion(String id);
}
