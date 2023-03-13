import 'package:flutter/material.dart';
import 'package:mb_control/widgets/drawer/custom_drawer.dart';

class Base extends StatefulWidget {
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
  State<Base> createState() => _BaseState();
}

class _BaseState extends State<Base> {
  // int currentIndex = 0;
  // final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: Container(),
        flexibleSpace: ClipPath(
          clipper: _HeaderClipper(),
          child: Container(
            height: 200,
            width: size.width,
            color: const Color(0xFF000B49),
            child: Row(
              children: [
                Expanded(
                    flex: 2,
                    child: IconButton(
                        onPressed: () =>
                            _scaffoldKey.currentState?.openDrawer(),
                        icon: const Icon(
                          Icons.menu,
                          color: Colors.white,
                        ))),
                Expanded(
                  flex: 8,
                  child: Center(
                    child: Text(
                      widget.title,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
                Expanded(flex: 2, child: Container())
              ],
            ),
          ),
        ),
      ),

      drawer: const CustomDrawer(),
      body: widget.body,
      // bottomNavigationBar: CurvedNavigationBar(
      //   key: _bottomNavigationKey,
      //   index: 0,
      //   height: 75.0,
      //   items: routes
      //       .map((e) => Icon(e.leading, color: Colors.white, size: 30))
      //       .toList(),
      //   color: const Color(0xFF000B49),
      //   buttonBackgroundColor: const Color(0xFF000B49),
      //   backgroundColor: Colors.transparent,
      //   animationCurve: Curves.easeInOut,
      //   animationDuration: const Duration(milliseconds: 600),
      //   onTap: (index) {
      //     setState(() {
      //       currentIndex = index;
      //     });
      //   },
      //   letIndexChange: (index) => true,
      // ),
    );
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
