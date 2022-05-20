import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:gurdain_app/api/profile.dart';
import 'package:gurdain_app/models/user.dart';
import 'package:intl/intl.dart';
import 'package:maps_launcher/maps_launcher.dart';

import '../constants/constants.dart';

class UserCard extends StatefulWidget {
  final User user;
  const UserCard({Key? key, required this.user}) : super(key: key);

  @override
  State<UserCard> createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      margin: const EdgeInsets.only(bottom: defaultPadding),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: const BoxDecoration(
        color: primaryPurple,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: Row(
        children: [
          SvgPicture.asset(widget.user.gender == "m"
              ? "assets/icons/avatar.svg"
              : "assets/icons/female_avatar.svg"),
          const SizedBox(
            width: defaultPadding,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.user.name,
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                "DOB: " + DateFormat("d-MMMM-yy").format(widget.user.dob),
                style: const TextStyle(color: Color(0xFFF0F0F0), fontSize: 14),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                "Type: " + widget.user.handicapType,
                style: const TextStyle(color: Color(0xFFF0F0F0), fontSize: 14),
              ),
            ],
          ),
          const Spacer(),
          loading
              ? const CircularProgressIndicator()
              : widget.user.accepted
                  ? InkWell(
                      onTap: () async {
                        ProfileApi profileApi = ProfileApi();
                        setState(() {
                          loading = true;
                        });
                        final result =
                            await profileApi.getLocation(widget.user.id);
                        setState(() {
                          loading = false;
                        });

                        if (result != null) {
                          MapsLauncher.launchCoordinates(
                              result.lat, result.lng);
                        }
                      },
                      child: const Text(
                        "View location",
                        style: TextStyle(
                          color: Color(0xFF19E567),
                          fontSize: 14,
                        ),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: InkWell(
                        onTap: () async {
                          setState(() {
                            loading = true;
                          });

                          ProfileApi profileApi = ProfileApi();
                          //    await Future.delayed(const Duration(seconds: 3));
                          final result =
                              await profileApi.connectUser(widget.user.id);

                          if (result != null) {
                            widget.user.accepted = true;
                          }
                          //
                          setState(() {
                            loading = false;
                          });
                        },
                        child: SvgPicture.asset(
                          "assets/icons/check.svg",
                          height: 40,
                          width: 40,
                          color: const Color(0xFF19E567),
                        ),
                      ))
        ],
      ),
    );
  }
}
