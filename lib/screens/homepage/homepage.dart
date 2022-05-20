import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gurdain_app/controllers/app_controller.dart';
import 'package:gurdain_app/screens/authentification/mobile_page.dart';
import 'package:gurdain_app/screens/constants/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../widgets/bottom_navigation_bar.dart';
import '../../widgets/events_slider.dart';
import 'user_list.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(AppController());
    return SafeArea(
        child: Scaffold(
      bottomNavigationBar: const BottomNavigationBarCustom(
        currentIndex: 0,
      ),
      appBar: AppBar(
        title: const Text("Gurdian App"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    SharedPreferences.getInstance().then((pref) {
                      pref.remove("phone");
                      pref.remove("access_token");
                      pref.remove("refresh_token");
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute<void>(
                              builder: (BuildContext context) =>
                                  const MobileEntry()),
                          (route) => false);
                    });
                  },
                  child: const Text(
                    "Log Out",
                    style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                ),
              ],
            ),
          )
        ],
        automaticallyImplyLeading: false,
        backgroundColor: primaryPurple,
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: defaultPadding),
            child: SizedBox(
              height: 180,
              child: EventsSlider(),
            ),
          ),
          ListUsers(),
        ],
      ),
    ));
  }
}
