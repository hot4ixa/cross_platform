class Endpoints {
  Endpoints._();

  static const String content = '/champions';
  static String champion(String id) => '/champions/$id';
}
