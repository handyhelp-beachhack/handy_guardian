import 'package:get/get.dart';
import 'package:gurdain_app/api/base_api.dart';
import 'package:gurdain_app/models/event_jobs.dart';
import 'package:gurdain_app/models/job_model.dart';

import '../widgets/toasts/app_toast.dart';

class CommonFeatures extends BaseApi {
  Future<List<EventModel>?> getEvents() async {
    try {
      final decoded = await getRequest("/user/v1/event/get/600");

      final a = decoded["response"]["events"];
      if (decoded["response_code"] == 200) {
        return List.from(a.map((e) => EventModel.fromMap(e)).toList());
      }
    } catch (e) {
      AppToast(text: e.toString(), toastType: ToastType.wrong)
        ..showToast(Get.overlayContext!);
    }
    return null;
  }
   Future<List<JobModel>?> getJobs() async {
    try {
      final decoded = await getRequest("/user/v1/job/get");

      final a = decoded["response"]["jobs"];
      if (decoded["response_code"] == 200) {
        return List.from(a.map((e) => JobModel.fromMap(e)).toList());
      }
    } catch (e) {
      AppToast(text: e.toString(), toastType: ToastType.wrong)
        ..showToast(Get.overlayContext!);
    }
    return null;
  }
}
