import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OtpTextField extends StatefulWidget {
  final int length;
  final double width;
  final String initialText;
  final TextInputType? keyboardType;

  final Function(bool)? onFocusChange;
  final Function(String) onEntered;
  const OtpTextField(
      {Key? key,
      required this.length,
      this.initialText = "",
      this.keyboardType,
      this.onFocusChange,
      required this.width,
      required this.onEntered})
      : super(key: key);

  @override
  State<OtpTextField> createState() => _OtpTextFieldState();
}

class _OtpTextFieldState extends State<OtpTextField> {
  final List<TextEditingController> _textEditingControllers = [];
  final List<FocusNode> _focusNodes = [];

  @override
  void initState() {
    super.initState();
    List<String> a;
    if (widget.initialText.isNotEmpty) {
      a = widget.initialText.split("");
    } else {
      a = List.generate(widget.length, (index) => "");
    }

    for (int i = 0; i < widget.length; i++) {
      _textEditingControllers.add(TextEditingController(text: a[i]));
      _focusNodes.add(FocusNode());

      _focusNodes[i].addListener(() {
        if (widget.onFocusChange != null) {
          widget.onFocusChange!(_focusNodes[i].hasFocus);
        }
      });
    }
  }

  @override
  void dispose() {
    super.dispose();

    for (int i = 0; i < widget.length; i++) {
      _textEditingControllers[i].dispose();
      _focusNodes[i].dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(widget.length, (index) {
        return Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: SizedBox(
            height: 100,
            width: widget.width,
            child: SingleTextField(
                keyboardType: widget.keyboardType,
                textEditingController: _textEditingControllers[index],
                focusNode: _focusNodes[index],
                onChanged: (val) {
                  debugPrint(val);
                  if (val.isEmpty) {
                    return;
                  }

                  _focusNodes[index].unfocus();
                  if (index != widget.length - 1) {
                    _focusNodes[index + 1].requestFocus();
                  }

                  bool hasValue = true;
                  String text = "";
                  for (TextEditingController controller
                      in _textEditingControllers) {
                    if (controller.text.isEmpty) {
                      hasValue = false;
                      break;
                    } else {
                      text += controller.text;
                    }
                  }

                  if (hasValue) {
                    widget.onEntered(text);
                  }
                }),
          ),
        );
      }),
    );
  }
}

class SingleTextField extends StatelessWidget {
  final FocusNode focusNode;
  final TextEditingController textEditingController;
  final Function(String) onChanged;
  final TextInputType? keyboardType;
  const SingleTextField(
      {Key? key,
      required this.textEditingController,
      required this.focusNode,
      this.keyboardType,
      required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      textAlign: TextAlign.center,
      focusNode: focusNode,
      keyboardType: keyboardType,
      controller: textEditingController,
      maxLengthEnforcement: MaxLengthEnforcement.enforced,
      maxLength: 1,
      style: const TextStyle(fontSize: 25),
      onChanged: onChanged,
      decoration: InputDecoration(
        counterText: "",
        fillColor: Colors.transparent,
        filled: true,
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).iconTheme.color!),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).iconTheme.color!),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).iconTheme.color!),
        ),
      ),
    );
  }
}
