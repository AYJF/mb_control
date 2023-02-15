import 'package:flutter/material.dart';

class Base extends StatelessWidget {
  const Base({
    Key? key,
    required this.body,
    this.title = 'Welcome',
    this.showBackBtn = false,
  }) : super(key: key);

  final String title;
  final Widget body;
  final bool showBackBtn;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 80,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: Container(),
          flexibleSpace: ClipPath(
            clipper: _HeaderClipper(),
            child: Container(
              height: 150,
              // width: size.width,
              color: const Color(0xFF000B49),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 2,
                    child: showBackBtn
                        ? IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: const Icon(
                              Icons.arrow_back_ios_rounded,
                              color: Colors.white,
                            ))
                        : Container(),
                  ),
                  Expanded(
                    flex: 6,
                    child: Text(
                      title,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  Expanded(flex: 2, child: Container())
                ],
              ),
            ),
          ),
        ),
        body: body);
  }
}

class _HeaderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double h = size.height;
    double w = size.width;

    Path path = Path();

    path.lineTo(0, h - 50);
    path.quadraticBezierTo(w / 2, h, w, h - 50);
    path.lineTo(w, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
