import 'model/model.dart';

abstract class UserDataServiceInterface {
  Future<UserData> getUserData();
  Future<void> addUserData({required String name, required String email});
  Future<void> updateUserData({required String name, required String description});
  Future<void> deleteUserData();

  Future<void> addToFavorites(String itemId);
  Future<void> removeFromFavorites(String itemId);
  Future<bool> isFavorite(String itemId);
}