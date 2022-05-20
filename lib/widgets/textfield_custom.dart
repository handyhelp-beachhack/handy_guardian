import 'package:flutter/material.dart';

import '../screens/constants/constants.dart';

class TextFieldCustom extends StatefulWidget {
  const TextFieldCustom({
    Key? key,
    this.width = double.maxFinite,
    required this.hintText,
    this.pass = false,
    required this.textEditingController,
    this.validate = false,
    this.bgColor = Colors.white,
    this.hintstyle,
    this.keyboardType = TextInputType.text,
  }) : super(key: key);

  final Color bgColor;
  final double width;
  final bool validate;
  final String hintText;
  final bool pass;
  final TextStyle? hintstyle;
  final TextInputType keyboardType;
  final TextEditingController textEditingController;

  @override
  State<TextFieldCustom> createState() => _TextFieldCustomState();
}

class _TextFieldCustomState extends State<TextFieldCustom> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
                vertical: 5, horizontal: defaultPadding),
            width: widget.width,
            height: 55,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: widget.bgColor,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 10,
                    color: primaryPurple.withOpacity(0.1),
                  )
                ]),
            child: Form(
              child: TextFormField(
                controller: widget.textEditingController,
                obscureText: widget.pass,
                keyboardType: widget.keyboardType,
                decoration: InputDecoration(
                  hintText: widget.hintText,
                  border: InputBorder.none,
                  hintStyle: widget.hintstyle,
                ),
              ),
            ),
          ),
          if (widget.validate && widget.textEditingController.text == "")
            Container(
              padding: const EdgeInsets.only(top: 8, left: 8),
              width: widget.width,
              alignment: Alignment.centerLeft,
              child: const Text(
                "field required",
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 14,
                ),
              ),
            )
        ],
      ),
    );
  }
}
