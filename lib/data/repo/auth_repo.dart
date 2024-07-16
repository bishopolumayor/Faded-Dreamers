import 'package:faded_dreamers/data/api/api_client.dart';
import 'package:faded_dreamers/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

class AuthRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  AuthRepo({
    required this.apiClient,
    required this.sharedPreferences,
  });

  Future<Response> signUp(Map<String, dynamic> data) async {
    return await apiClient.postData(AppConstants.SIGN_UP_URI, data);
  }

  Future<Response> updateInfo(Map<String, dynamic> data) async {
    return await apiClient.postData(AppConstants.UPDATE_USER_DETAILS, data);
  }

  Future<Response> signIn(Map<String, dynamic> data) async {
    return await apiClient.postData(AppConstants.SIGN_IN_URI, data);
  }

  Future<Response> uploadSelfieImage(FormData formData) async {
    return await apiClient.postData(AppConstants.UPLOAD_AVATAR, formData);
  }

  Future<Response> resetPassword(Map<String, dynamic> data) async {
    return await apiClient.postData(AppConstants.RESET_PASSWORD, data);
  }

  Future<void> clearAllData() async {
    await sharedPreferences.clear();
  }

}