import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_budget_app_using_sqflite/uiDesign/home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(duration: Duration(seconds: 5), vsync: this);
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5), () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff3C3C3C),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 130.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: _controller,
              child: Container(
                alignment: Alignment.center,
                height: 300.0,
                width: 300.0,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: const AssetImage(
                            'assest/images/Letter_D_Logo_With_Nature_and_Water_Wave_Concept.-removebg-preview.png'),
                        fit: BoxFit.cover)),
              ),
              builder: (BuildContext context, Widget? child) {
                return Transform.rotate(
                  angle: _controller.value * 2 * 3.14159265359,
                  child: child,
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
