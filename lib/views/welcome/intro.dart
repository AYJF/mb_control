import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:mb_control/views/welcome/login_dialog.dart';
import 'package:rive/rive.dart';
import 'dart:ui' as ui;

class Intro extends StatefulWidget {
  const Intro({Key? key}) : super(key: key);

  @override
  State<Intro> createState() => _IntroState();
}

class _IntroState extends State<Intro> {
  late RiveAnimationController _controller;

  /// Is the animation currently playing?
  bool _isPlaying = false;
  @override
  void initState() {
    super.initState();
    _controller = OneShotAnimation(
      'active',
      autoplay: false,
      onStop: () => setState(() => _isPlaying = false),
      onStart: () => setState(() => _isPlaying = true),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: BackdropFilter(
      filter: ui.ImageFilter.blur(
        sigmaX: 30.0,
        sigmaY: 30.0,
      ),
      child: Stack(
        children: [
          const Positioned.fill(
            child: RiveAnimation.asset(
              'assets/rive/shapes.riv',
            ),
          ),
          Positioned(
            top: size.height * 0.3,
            left: size.width * 0.15,
            child: Container(
              width: size.width + 100,
              height: size.height * 0.6,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      'assets/images/shapes/Spline.png',
                    ),
                    fit: BoxFit.fill),
              ),
              child: BackdropFilter(
                filter: ui.ImageFilter.blur(
                  sigmaX: 50.0,
                  sigmaY: 50.0,
                ),
                child: SizedBox(
                  width: size.width,
                  height: size.height,
                ),
              ),
            ),
          ),
          const Positioned(
              top: 150,
              left: 40,
              child: Text(
                "Market \n& Go ",
                style: TextStyle(
                  fontSize: 60,
                  fontWeight: FontWeight.bold,
                ),
              )),
          Positioned(
              top: 350,
              left: 40,
              child: SizedBox(
                width: size.width * 0.8,
                child: Text(
                  "Con simples pasos tenga acceso a todos sus datos con control absoluto y organizado, todo al alcance de su mano",
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black.withOpacity(0.5)),
                ),
              )),
          Positioned(
              bottom: 100,
              left: 40,
              child: GestureDetector(
                onTap: () {
                  _isPlaying ? null : _controller.isActive = true;
                  showAnimatedDialog(
                    context: context,
                    barrierDismissible: true,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        insetPadding:
                            const EdgeInsets.symmetric(horizontal: 20),
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        title: const Text(
                          'Sign in',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 34, fontWeight: FontWeight.w700),
                        ),
                        content: SizedBox(
                          height: 500,
                          width: size.width * 0.95,
                          child: Column(
                            children: const [
                              Text(
                                'Acceda a una aplicacion customizada enfocada a mejorar la experiencia del usuario con cada click',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color.fromRGBO(0, 0, 0, 0.5),
                                ),
                              ),
                              LoginDialog(),
                            ],
                          ),
                        ),
                      );
                    },
                    animationType: DialogTransitionType.slideFromTop,
                    curve: Curves.fastOutSlowIn,
                    duration: const Duration(seconds: 1),
                  );
                },
                child: SizedBox(
                    width: 236,
                    height: 64,
                    child: Stack(
                      alignment: AlignmentDirectional.center,
                      children: [
                        RiveAnimation.asset(
                          'assets/rive/button.riv',
                          animations: const ['active'],
                          controllers: [_controller],
                        ),
                        Positioned(
                          top: 23,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                "Comenzar",
                                style: TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 16),
                              ),
                              SizedBox(
                                width: 12,
                              ),
                              Icon(Icons.arrow_forward_rounded)
                            ],
                          ),
                        )
                      ],
                    )),
              ))
        ],
      ),
    ));
  }
}
