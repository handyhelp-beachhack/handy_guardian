import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gurdain_app/api/common_features.dart';
import 'package:gurdain_app/controllers/app_controller.dart';
import 'package:gurdain_app/models/event_jobs.dart';
import 'package:gurdain_app/screens/constants/constants.dart';
import 'package:intl/intl.dart';

import '../screens/events/event_view_page.dart';

class EventsSlider extends StatefulWidget {
  const EventsSlider({Key? key}) : super(key: key);

  @override
  State<EventsSlider> createState() => _EventsSliderState();
}

class _EventsSliderState extends State<EventsSlider> {
  int currentPage = 0;
  bool loading = true;
  List<dynamic> items = [];
  late PageController pageController;
  late AppController appController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    appController = Get.find<AppController>();
    pageController = PageController(viewportFraction: 0.93);

    // ignore: avoid_single_cascade_in_expression_statements
    CommonFeatures()
      ..getEvents().then((value) {
        if (value != null) {
          appController.events = value;
          if (appController.events.isNotEmpty) {
            items.add(appController.events[0]);
          }

          setState(() {
            loading = false;
          });
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: loading
              ? _loadingWidget()
              : PageView.builder(
                  controller: pageController,
                  onPageChanged: (index) {
                    setState(() {
                      currentPage = index;
                    });
                  },
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return Padding(
                        padding: const EdgeInsets.only(right: defaultPadding),
                        child: EventSlideCard(event: items[index]));
                  }),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
              items.length,
              (index) => Container(
                    height: 12,
                    width: 12,
                    margin: const EdgeInsets.only(right: 5),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: index == currentPage ? primaryPurple : grey,
                    ),
                  )),
        )
      ],
    );
  }

  Widget _loadingWidget() => Container(
        decoration: const BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          color: Colors.white,
        ),
        child: Column(
          children: [],
        ),
      );
}

class EventSlideCard extends StatelessWidget {
  final EventModel event;
  const EventSlideCard({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => EventViewPage(
                      event: event,
                    )));
      },
      child: Stack(
        fit: StackFit.expand,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            child: Image.network(
              event.img,
              fit: BoxFit.fill,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 100),
            height: 40,
            width: double.infinity,
            padding: const EdgeInsets.only(left: 10),
            alignment: Alignment.centerLeft,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(12),
                    bottomLeft: Radius.circular(12)),
                gradient: LinearGradient(
                    colors: [Colors.black, Colors.transparent],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter)),
            child: Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Row(
                children: [
                  Text(
                    event.name,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  Text(
                    DateFormat("d-MMMM-yy").format(event.eventDate),
                    style: const TextStyle(
                      color: grey,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
