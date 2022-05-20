import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gurdain_app/screens/jobs/job_view_page.dart';

import '../screens/constants/constants.dart';
import '../screens/events/events_page.dart';
import '../screens/homepage/homepage.dart';

class BottomNavigationBarCustom extends StatefulWidget {
  const BottomNavigationBarCustom({Key? key, required this.currentIndex})
      : super(key: key);
  final int currentIndex;

  @override
  State<BottomNavigationBarCustom> createState() =>
      _BottomNavigationBarCustomState();
}

class _BottomNavigationBarCustomState extends State<BottomNavigationBarCustom> {
  @override
  Widget build(BuildContext context) {
    List pages = [const HomePage(), const EventPage(), const JobViewPage()];
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      currentIndex: widget.currentIndex,
      onTap: (newIndex) {
        setState(() {
          if (newIndex != widget.currentIndex) {
            Get.to(pages[newIndex]);
          }
        });
      },
      items: [
        BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: widget.currentIndex == 0 ? primaryPurple : Colors.grey,
              size: 28,
            ),
            label: "home"),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.event,
            color: widget.currentIndex == 1 ? primaryPurple : Colors.grey,
            size: 28,
          ),
          label: "event",
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.business,
            color: widget.currentIndex == 2 ? primaryPurple : Colors.grey,
            size: 28,
          ),
          label: "job",
        ),
      ],
    );
  }
}
