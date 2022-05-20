import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';

import '../../screens/constants/constants.dart';

enum ToastType { success, wrong }

class AppToast {
  final String text;
  OverlayEntry? _entry;
  final ToastType toastType;

  AppToast({required this.text, required this.toastType});

  void showToast(
    BuildContext context,
  ) {
    remove();
    _entry = OverlayEntry(
        builder: (context) => AppToastWidget(
              entry: _entry!,
              child: toastType == ToastType.success
                  ? ToastBody.success(text)
                  : ToastBody.wrong(text),
            ));

    Overlay.of(context)?.insert(_entry!);
  }

  void remove() {
    if (_entry != null && _entry!.mounted) {
      _entry?.remove();
      _entry = null;
    }
  }
}

class AppToastWidget extends StatefulWidget {
  final OverlayEntry entry;
  final Widget child;
  const AppToastWidget({Key? key, required this.entry, required this.child})
      : super(key: key);

  @override
  State<AppToastWidget> createState() => _AppToastWidgetState();
}

class _AppToastWidgetState extends State<AppToastWidget> {
  bool _showAnimation = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      setState(() {
        _showAnimation = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
            onTap: () {
              setState(() {
                _showAnimation = false;
              });
            },
            child: Container(
              margin: const EdgeInsets.only(top: 90),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: Colors.transparent,
            )),
        SafeArea(
          minimum: const EdgeInsets.only(top: 50, left: 5, right: 5),
          child: IgnorePointer(
            ignoring: true,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: _showAnimation ? 60 : 0,
              onEnd: () {
                if (!_showAnimation) {
                  widget.entry.remove();
                }
              },
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Theme.of(context).canvasColor,
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4,
                        spreadRadius: 4,
                        offset: Offset(0, 0))
                  ]),
              child: widget.child,
            ),
          ),
        ),
      ],
    );
  }
}

class ToastBody extends StatefulWidget {
  final String text;
  final String icon;

  const ToastBody({Key? key, required this.text, required this.icon})
      : super(key: key);
  factory ToastBody.success(String text) =>
      ToastBody(text: text, icon: "assets/lottie_animation/tick.json");
  factory ToastBody.wrong(String text) =>
      ToastBody(text: text, icon: "assets/lottie_animation/close.json");
  @override
  State<ToastBody> createState() => _ToastBodyState();
}

class _ToastBodyState extends State<ToastBody> {
  bool _animate = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(const Duration(milliseconds: 200))
        .then((value) => setState(() {
              _animate = true;
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(
          width: defaultPadding,
        ),
        Lottie.asset(widget.icon,
            repeat: false, animate: _animate, height: 40, width: 40),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Text(
            widget.text,
            style: const TextStyle(
                color: Colors.black,
                fontSize: 15,
                decoration: TextDecoration.none),
          ),
        )
      ],
    );
  }
}
