import 'package:get/get.dart';
import 'package:gurdain_app/models/event_jobs.dart';
import 'package:gurdain_app/models/user.dart';

import '../widgets/toasts/app_toast.dart';
import 'base_api.dart';

class ProfileApi extends BaseApi {
  Future<List<User>?> getUsers() async {
    try {
      final decoded = await getRequest("/user/v1/profile/get");

      if (decoded["response_code"] == 200) {
        List users = decoded["response"]["user"]["connect_requests"]
            .map((e) => User.fromJson(e, false))
            .toList();

        decoded["response"]["user"]["connected"].forEach((e) {
          e["id"] = e["_id"];
          print(e);
          users.add(User.fromJson(e, true));
        });
        return List.from(users);
      }
    } catch (e) {
      AppToast(text: e.toString(), toastType: ToastType.wrong)
        ..showToast(Get.overlayContext!);
    }
    return null;
  }

  Future<String?> connectUser(String id) async {
    try {
      final decoded =
          await postRequest("/user/v1/profile/guardian/connect", {"id": id});

      if (decoded["response_code"] == 200) {
        return decoded["message"];
      }
    } catch (e) {
      print(e.toString());
      AppToast(text: e.toString(), toastType: ToastType.wrong)
        ..showToast(Get.overlayContext!);
    }
    return null;
  }

  Future<LatLng?> getLocation(String id) async {
    try {
      final decoded =
          await postRequest("/user/v1/profile/get/user/location", {"id": id});

      if (decoded["response_code"] == 200) {
        return LatLng(decoded["response"]["location"][1],
            decoded["response"]["location"][0]);
      }
    } catch (e) {
      print(e.toString());
      AppToast(text: e.toString(), toastType: ToastType.wrong)
        ..showToast(Get.overlayContext!);
    }
    return null;
  }
}
