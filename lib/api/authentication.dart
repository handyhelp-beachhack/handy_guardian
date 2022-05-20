import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:gurdain_app/api/base_api.dart';
import 'package:gurdain_app/widgets/toasts/app_toast.dart';

import 'package:shared_preferences/shared_preferences.dart';

class Authentication extends BaseApi {
  Future<String?> getOTP(String mobile) async {
    Map<String, String> body = {"phone": mobile, "account_type": "guardian"};

    try {
      final decoded =
          await postRequest("/auth/v1/login", body, useToken: false);
      if (decoded["response_code"] == 200) {
        return decoded["message"];
      }
    } catch (e) {
      debugPrint(e.toString());
      AppToast(text: e.toString(), toastType: ToastType.wrong)
        ..showToast(Get.overlayContext!);
    }
    return null;
  }

  Future<int?> verifyOTP(String mobile, String otp) async {
    final fcmToken = await FirebaseMessaging.instance.getToken();
    Map<String, dynamic> body = {
      "phone": mobile,
      "otp": otp,
      "device": {
        "fcm": fcmToken,
      }
    };
    try {
      final decoded =
          await postRequest("/auth/v1/validate/otp/", body, useToken: false);
      if (decoded["response_code"] == 200) {
        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setString("access_token", decoded["response"]["accessToken"]);
        pref.setString("refresh_token", decoded["response"]["refreshToken"]);
        pref.setString("mobile", decoded["response"]["user"]["phone"]);
        return decoded["response"]["user"]["profile_completion"];
      }
    } catch (e) {
      debugPrint(e.toString());
      AppToast(text: e.toString(), toastType: ToastType.wrong)
        ..showToast(Get.overlayContext!);
    }
    return null;
  }

  Future<String?> putName(String name) async {
    Map<String, dynamic> body = {"name": name, "lat": 10.2649, "lon": 76.3487};
    try {
      final decoded =
          await postRequest("/user/v1/profile/update/guardian", body);
      if (decoded["response_code"] == 200) {
        return decoded["message"];
      }
    } catch (e) {
      debugPrint(e.toString());
      AppToast(text: e.toString(), toastType: ToastType.wrong)
        ..showToast(Get.overlayContext!);
    }
    return null;
  }
}
