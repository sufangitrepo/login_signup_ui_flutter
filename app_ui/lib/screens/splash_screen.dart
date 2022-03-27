import 'dart:async';

import 'package:app_ui/screens/welcome_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {}

  void homeSplash() {
    Timer(Duration(milliseconds: 5000), () {
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) {
          return WelComePage();
        },
      ));
    });
  }

  void homeSplash2() {
    Future.delayed(Duration(milliseconds: 3000), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => WelComePage(),
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: const [
          Spacer(
            flex: 3,
          ),
          Expanded(
            child: Center(
              child: ImageIcon(
                AssetImage('assets/images/splash_icon.png'),
                color: Color(0Xff98c4ec),
                size: 80,
              ),
            ),
            flex: 2,
          ),
          Spacer(
            flex: 2,
          ),
          Expanded(
            child: Center(
              child: Text(
                'Haven',
                style: TextStyle(
                  color: Color(0Xff98c4ec),
                  fontSize: 20,
                ),
              ),
            ),
            flex: 3,
          ),
        ],
      ),
    );
  }
}
