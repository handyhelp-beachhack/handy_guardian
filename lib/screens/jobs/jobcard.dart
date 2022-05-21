import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gurdain_app/models/job_model.dart';
import 'package:gurdain_app/view/constants/constants.dart';

class Jobcard extends StatelessWidget {
  const Jobcard({Key? key, required this.job}) : super(key: key);
  final JobModel job;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Image.network(
                    "https://images8.alphacoders.com/104/thumb-1920-1048376.jpg"),
                Container(
                  height: 50,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                        primaryPurple.withOpacity(0.0),
                        primaryPurple,
                      ])),
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: defaultPadding,
                    ),
                    Text(
                      "posted by ${job.postedBy} on\n${job.createdAt.toString().substring(0, 10)}",
                      style: TextStyle(
                        color: white.withOpacity(.7),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    job.name,
                    style: TextStyle(
                        color: white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    job.description,
                    style: TextStyle(
                      color: white,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Text(
                    "closes at ${job.endDate.day.toString()}-${job.endDate.month.toString()}-${job.endDate.year.toString()}",
                    style: TextStyle(
                      color: white,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Text(
                    "salary ${job.lpa}",
                    style: TextStyle(
                      color: white,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(
                    height: defaultPadding,
                  ),
                  Text(
                    "preffered for ${job.handicapType}",
                    style: TextStyle(
                      color: white,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(
                    height: defaultPadding,
                  ),
                  Container(
                    height: 60,
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: white.withOpacity(0.3)),
                    padding: EdgeInsets.all(8),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "contact number",
                            style: TextStyle(
                              color: white,
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            job.contactNumber,
                            style: TextStyle(
                              color: white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ]),
                  ),
                  const SizedBox(
                    height: defaultPadding * 2,
                  ),
                  // Container(
                  //   height: 80,
                  //   width: 200,
                  //   alignment: Alignment.center,
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(10),
                  //     color: Color(0xff32BEA6),
                  //   ),
                  //   child: Text(
                  //     "View on maps",
                  //     style: TextStyle(
                  //       color: white,
                  //       fontSize: 20,
                  //       fontWeight: FontWeight.bold,
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
