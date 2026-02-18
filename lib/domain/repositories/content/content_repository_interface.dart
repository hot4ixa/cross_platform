import 'model/content.dart';

abstract interface class ContentRepositoryInterface {
  Future<List<Content>> getContent();
  Future<List<Content>> getContentByIds( List<String> ids );
  Future<Content> getChampion(String id);
}
