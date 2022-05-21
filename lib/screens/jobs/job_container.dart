import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gurdain_app/screens/jobs/jobcard.dart';

import '../../models/job_model.dart';
import '../../view/constants/constants.dart';

class JobContainer extends StatelessWidget {
  const JobContainer({
    Key? key,
    required this.job,
  }) : super(key: key);
  final JobModel job;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: defaultPadding, horizontal: defaultPadding),
      child: InkWell(
        onTap: () {
          Get.to(Jobcard(job: job));
        },
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                      height: 130,
                      width: double.maxFinite,
                      child: Image(
                          fit: BoxFit.fill,
                          image: Image.network(
                            "https://images8.alphacoders.com/104/thumb-1920-1048376.jpg",
                            // errorListener: () {
                            // debugPrint("error");
                          ).image)),
                ),
                Positioned(
                    bottom: 20,
                    right: 10,
                    child: Text(
                      job.name,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: white),
                    )),
                Positioned(
                    bottom: 4,
                    right: 10,
                    child: Text(
                      "${job.lpa}/year",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: white),
                    ))
              ],
            ),
            SizedBox(
              height: defaultPadding,
            )
          ],
        ),
      ),
    );
  }
}
