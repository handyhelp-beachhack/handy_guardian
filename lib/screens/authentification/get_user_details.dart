import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gurdain_app/screens/homepage/homepage.dart';

import '../../api/authentication.dart';
import '../../widgets/buttons/rounded_rect_primary_button.dart';
import '../../widgets/textfield_custom.dart';
import '../../widgets/toasts/app_toast.dart';
import '../constants/constants.dart';

class GetUserDetails extends StatefulWidget {
  const GetUserDetails({Key? key}) : super(key: key);

  @override
  State<GetUserDetails> createState() => _GetUserDetailsState();
}

class _GetUserDetailsState extends State<GetUserDetails> {
  bool isLoading = false;
  TextEditingController mobileController = TextEditingController();

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
                    "Guardian Name",
                    style: TextStyle(
                      fontSize: 19,
                      color: primaryPurple,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Text(
                    "Enter your name to continue",
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
                        hintText: "Name",
                        keyboardType: TextInputType.name,
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
                            await authentication.putName(mobileController.text);
                        setState(() {
                          isLoading = false;
                        });
                        if (result != null) {
                          AppToast(text: result, toastType: ToastType.success)
                            ..showToast(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomePage()));
                        }
                      })
                ]),
          ),
        ),
      ),
    );
  }
}
