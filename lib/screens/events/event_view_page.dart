import 'package:flutter/material.dart';
import 'package:gurdain_app/models/event_jobs.dart';
import 'package:maps_launcher/maps_launcher.dart';

import '../constants/constants.dart';

class EventViewPage extends StatelessWidget {
  final EventModel event;
  const EventViewPage({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: primaryPurple,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Image.network(event.img),
                //   CachedNetworkImage(imageUrl: event.img),
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
                      "created by ${event.postedBy}",
                      style: TextStyle(
                        color: Colors.white.withOpacity(.7),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event.name,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    event.description,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Text(
                    "${event.eventDate.day.toString()}-${event.eventDate.month.toString()}-${event.eventDate.year.toString()}",
                    style: const TextStyle(
                      color: Colors.white,
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
                        color: Colors.white.withOpacity(0.3)),
                    padding: const EdgeInsets.all(8),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text(
                            "contact number",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            event.contactNumber,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ]),
                  ),
                  const SizedBox(
                    height: defaultPadding * 2,
                  ),
                  InkWell(
                    onTap: () {
                      MapsLauncher.launchCoordinates(
                          event.location.lat, event.location.lng);
                    },
                    child: Container(
                      height: 80,
                      width: 200,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xff32BEA6),
                      ),
                      child: const Text(
                        "View on maps",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
