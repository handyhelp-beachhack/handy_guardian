import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/toasts/app_toast.dart';

class BaseApi {
  final String _baseUrl = "https://app.geekstudios.tech";

  Future<Map<String, dynamic>> getRequest(String endpoint,
      {bool useToken = true}) async {
    Map<String, String> header = {"Content-Type": "application/json"};

    if (useToken) {
      SharedPreferences pref = await SharedPreferences.getInstance();
      final accessToken = pref.getString("access_token");
      //final refreshToken = pref.getString("refresh_token");
      header["Authorization"] = "Bearer $accessToken";
    }

    http.Response response = await http
        .get(
          Uri.parse(_baseUrl + endpoint),
          headers: header,
        )
        .timeout(const Duration(seconds: 3));

    if (response.statusCode != 200) {
      //show Toast

      AppToast(
          text: json.decode(response.body)["message"],
          toastType: ToastType.success)
        ..showToast(Get.overlayContext!);
    }
    return json.decode(response.body);
  }

  Future<Map<String, dynamic>> postRequest(
      String endpoint, Map<String, dynamic> body,
      {bool useToken = true}) async {
    Map<String, String> header = {"Content-Type": "application/json"};
    if (useToken) {
      SharedPreferences pref = await SharedPreferences.getInstance();
      final accessToken = pref.getString("access_token");
      //final refreshToken = pref.getString("refresh_token");
      header["Authorization"] = "Bearer $accessToken";
    }
    print(body);
    http.Response response = await http
        .post(
          Uri.parse(_baseUrl + endpoint),
          headers: header,
          body: json.encode(body),
        )
        .timeout(const Duration(seconds: 3));

    print(response.body);
    if (response.statusCode != 200 ||
        json.decode(response.body)["response_code"] != 200) {
      //show Toast

      AppToast(
          text: json.decode(response.body)["message"],
          toastType: ToastType.wrong)
        ..showToast(Get.overlayContext!);
    }
    return json.decode(response.body);
  }
}
