import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:gurdain_app/api/common_features.dart';

import 'package:gurdain_app/controllers/app_controller.dart';

import 'package:gurdain_app/screens/jobs/jobcard.dart';
// import 'package:gurdain_app/screens/constants/constants.dart';
import 'package:gurdain_app/view/constants/constants.dart';

import 'job_container.dart';

class JobViewPage extends StatefulWidget {
  const JobViewPage({
    Key? key,
  }) : super(key: key);

  @override
  State<JobViewPage> createState() => _JobViewPageState();
}

class _JobViewPageState extends State<JobViewPage> {
  late AppController appController;
  bool loading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    appController = Get.find<AppController>();

    // ignore: avoid_single_cascade_in_expression_statements
    CommonFeatures()
      ..getJobs().then((value) {
        setState(() {
          loading = false;
          if (value != null) {
            appController.jobs = value;
          }
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: bgColor,
            appBar: AppBar(
              backgroundColor: primaryPurple,
              title: Text("Job Portal"),
            ),
            body: loading
                ? const CircularProgressIndicator()
                : ListView.builder(
                    itemCount: appController.jobs.length,
                    itemBuilder: (context, index) => JobContainer(
                          job: appController.jobs[index],
                        ))));
  }
}
