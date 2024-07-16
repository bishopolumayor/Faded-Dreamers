import 'dart:convert';

import 'package:faded_dreamers/data/api/api_client.dart';
import 'package:faded_dreamers/models/user_model.dart';
import 'package:faded_dreamers/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  UserRepo({
    required this.apiClient,
    required this.sharedPreferences,
  });


  Future<void> saveUser(UserModel user) async {
    String userJson = json.encode(user.toJson());
    await sharedPreferences.setString(AppConstants.USER_KEY, userJson);
  }

  Future<bool> checkUserExists() async {
    bool userExists = sharedPreferences.containsKey(AppConstants.USER_KEY);
    return userExists;
  }

  Future<UserModel?> getUser() async {
    String? userJson = sharedPreferences.getString(AppConstants.USER_KEY);
    if (userJson != null) {
      return UserModel.fromJson(json.decode(userJson));
    }
    return null;
  }

}