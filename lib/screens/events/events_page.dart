import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gurdain_app/controllers/app_controller.dart';
import 'package:gurdain_app/screens/constants/constants.dart';

import '../../widgets/bottom_navigation_bar.dart';
import '../../widgets/events_slider.dart';
import 'event_view_page.dart';

class EventPage extends StatelessWidget {
  const EventPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AppController appController = Get.find<AppController>();
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: const BottomNavigationBarCustom(currentIndex: 1),
        appBar: AppBar(
          backgroundColor: primaryPurple,
          title: const Text("Events"),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(defaultPadding),
          child: Column(
            children: [
              for (int i = 0; i < appController.events.length; i++)
                InkWell(
                  onTap: () {
                    Get.to(EventViewPage(
                      event: appController.events[i],
                    ));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: defaultPadding),
                    child: SizedBox(
                      height: 180,
                      child: EventSlideCard(
                        event: appController.events[i],
                      ),
                    ),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
