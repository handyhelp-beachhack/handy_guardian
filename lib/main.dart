import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gurdain_app/screens/authentification/mobile_page.dart';
import 'package:gurdain_app/screens/homepage/homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Gurdian App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: FutureBuilder<SharedPreferences>(
          future: SharedPreferences.getInstance(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.hasData) {
              if (snapshot.data?.getString("mobile") == null) {
                return const MobileEntry();
              } else {
                return const HomePage();
              }
            }
            return const Offstage();
          },
        ));
  }
}
