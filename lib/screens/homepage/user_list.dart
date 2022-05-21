import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gurdain_app/api/profile.dart';
import 'package:gurdain_app/controllers/app_controller.dart';
import 'package:gurdain_app/screens/constants/constants.dart';

import 'user_card.dart';

class ListUsers extends StatefulWidget {
  const ListUsers({Key? key}) : super(key: key);

  @override
  State<ListUsers> createState() => _ListUsersState();
}

class _ListUsersState extends State<ListUsers> {
  late AppController appController;
  bool _loading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    appController = Get.find<AppController>();
    ProfileApi().getUsers().then((value) {
      setState(() {
        _loading = false;

        if (value != null) {
          appController.users = value;
        }
      });
    });
    //   users = User.test();
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: defaultPadding, vertical: defaultPadding),
      child: appController.users.isEmpty
          ? const Center(
              child: Text(
              "Empty.",
              style: TextStyle(
                fontSize: 18,
              ),
            ))
          : Column(
              children: List.generate(
                  appController.users.length,
                  (index) => UserCard(
                        user: appController.users[index],
                      ))),
    );
  }
}
