import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gurdain_app/api/profile.dart';
import 'package:gurdain_app/screens/constants/constants.dart';
import 'package:intl/intl.dart';

import '../../models/user.dart';
import 'user_card.dart';

class ListUsers extends StatefulWidget {
  const ListUsers({Key? key}) : super(key: key);

  @override
  State<ListUsers> createState() => _ListUsersState();
}

class _ListUsersState extends State<ListUsers> {
  late List<User> users;
  bool _loading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ProfileApi().getUsers().then((value) {
      setState(() {
        _loading = false;

        if (value != null) {
          users = value;
        } else {
          users = [];
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
      child: users.isEmpty
          ? const Center(
              child: Text(
              "Empty.",
              style: TextStyle(
                fontSize: 18,
              ),
            ))
          : Column(
              children: List.generate(
                  users.length,
                  (index) => UserCard(
                        user: users[index],
                      ))),
    );
  }
}
