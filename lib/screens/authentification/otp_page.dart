import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';
import 'package:gurdain_app/screens/homepage/homepage.dart';

import '../../api/authentication.dart';
import '../../models/user.dart';
import '../../widgets/buttons/rounded_rect_primary_button.dart';
import '../../widgets/otp_textfield.dart';
import '../constants/constants.dart';
import 'get_user_details.dart';

class OtpPage extends StatefulWidget {
  const OtpPage(
      {Key? key,
      required this.mobile,
      required this.countryCode,
      required this.passedOtp})
      : super(key: key);

  @override
  _OtpPageState createState() => _OtpPageState();
  final String mobile;
  final String countryCode;
  final String passedOtp;
}

class _OtpPageState extends State<OtpPage> {
  TextEditingController mobileController = TextEditingController();
  TextEditingController countryController = TextEditingController(text: "+91");
  String token = "";
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          width: size.width,
          padding: EdgeInsets.all(defaultPadding),
          child: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  SvgPicture.asset(
                    "assets/icons/otp-svg.svg",
                    width: size.width - defaultPadding * 4,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Otp Verification",
                    style: TextStyle(
                      fontSize: 19,
                      color: primaryPurple,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Text(
                    "Enter the OTP to continue",
                    style: TextStyle(
                      fontSize: 10,
                      color: primaryPurple,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: defaultPadding,
                  ),
                  Align(
                      alignment: Alignment.center,
                      child: OtpTextField(
                        length: 6,
                        keyboardType: TextInputType.number,
                        width: 40,
                        onEntered: (String verificationCode) {
                          token += verificationCode;
                        },
                      )),
                  const SizedBox(
                    height: 50,
                  ),
                  const SizedBox(
                    height: 70,
                  ),
                  RoundedRectPrimaryButton(
                      text: "Continue",
                      onpressed: () async {
                        setState(() {
                          isLoading = true;
                        });
                        Authentication authentication = Authentication();
                        int? result = await authentication.verifyOTP(
                            widget.mobile, token);
                        setState(() {
                          isLoading = false;
                        });
                        if (result == 0) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const GetUserDetails()));
                        } else if (result == 1) {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute<void>(
                                  builder: (BuildContext context) =>
                                      const HomePage()),
                              (route) => false);
                        }
                        // int status = await RegisterApi.verificationApi(
                        //     mobile: widget.mobile,
                        //     countryCode: widget.countryCode,
                        //     otp: widget.passedOtp);
                      })
                ]),
          ),
        ),
      ),
    );
  }
}
