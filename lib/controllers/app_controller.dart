import 'package:get/get.dart';
import 'package:gurdain_app/models/event_jobs.dart';
import 'package:gurdain_app/models/job_model.dart';

import '../models/user.dart';

class AppController extends GetxController {
  List<EventModel> events = [];
  List<JobModel> jobs = [];
  List<User> users = [];
}
