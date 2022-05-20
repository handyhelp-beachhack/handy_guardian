import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:gurdain_app/api/authentication.dart';
import 'package:gurdain_app/screens/authentification/otp_page.dart';

import '../../widgets/buttons/rounded_rect_primary_button.dart';
import '../../widgets/textfield_custom.dart';
import '../../widgets/toasts/app_toast.dart';
import '../constants/constants.dart';

class MobileEntry extends StatefulWidget {
  const MobileEntry({Key? key}) : super(key: key);

  @override
  _MobileEntryState createState() => _MobileEntryState();
}

class _MobileEntryState extends State<MobileEntry> {
  TextEditingController mobileController = TextEditingController();

  bool isLoading = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    mobileController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: bgColor,
        body: Container(
          width: size.width,
          padding: const EdgeInsets.all(defaultPadding),
          child: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  SvgPicture.asset(
                    "assets/icons/login-svg.svg",
                    width: size.width - defaultPadding * 4,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Sign in/Sign up",
                    style: TextStyle(
                      fontSize: 19,
                      color: primaryPurple,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Text(
                    "Enter your mobile to continue",
                    style: TextStyle(
                      fontSize: 10,
                      color: primaryPurple,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: defaultPadding,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(defaultPadding),
                    child: TextFieldCustom(
                        hintText: "mobile",
                        keyboardType: TextInputType.number,
                        textEditingController: mobileController),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  const SizedBox(
                    height: 70,
                  ),
                  RoundedRectPrimaryButton(
                      loading: isLoading,
                      text: "Continue",
                      onpressed: () async {
                        setState(() {
                          isLoading = true;
                        });

                        Authentication authentication = Authentication();
                        String? result =
                            await authentication.getOTP(mobileController.text);
                        setState(() {
                          isLoading = false;
                        });
                        if (result != null) {
                          AppToast(text: result, toastType: ToastType.success)
                            ..showToast(Get.overlayContext!);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => OtpPage(
                                      mobile: mobileController.text,
                                      countryCode: "+91",
                                      passedOtp: "")));
                        }
                        // int statusCode = await RegisterApi.emailCheck(
                        //         mobile: mobileController.text,
                        //         countryCode: countryController.text)
                        //     .whenComplete(() {
                        //   setState(() {
                        //     isLoading = false;
                        //   });
                        // });

                        //    if (statusCode == 200) {
                        // Get.to(OtpPage(
                        //   mobile: mobileController.text,
                        //   countryCode: countryController.text,
                        // ));
                        //     print("Success");
                        //   } else {
                        // Get.to(OtpPage());
                        //   }
                      })
                ]),
          ),
        ),
      ),
    );
  }
}
