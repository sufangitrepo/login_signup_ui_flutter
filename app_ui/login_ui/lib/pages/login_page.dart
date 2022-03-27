import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:login_ui/pages/register_page.dart';
import 'package:login_ui/pages/show.dart';

typedef String? Validate(String s);

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    print(height);
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: const [
            TopBottomClipShape(),
            TopUpperClipShape(),
            Login(),
            BottomDownClipShape(),
            BottomUpClipShape(),
          ],
        ),
      ),
    );
  }
}

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late TextEditingController userNameController;
  late TextEditingController passwordControlelr;
  String text = '';
  bool isNotVisible = true;
  GlobalKey<FormState> key = GlobalKey();
  @override
  void initState() {
    super.initState();
    userNameController = TextEditingController();
    passwordControlelr = TextEditingController();
    userNameController.addListener(() {
      setState(() {
        text = userNameController.text;
      });
    });
  }

  @override
  void dispose() {
    userNameController.dispose();
    passwordControlelr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height - 25;
    double width = MediaQuery.of(context).size.width;
    return Form(
      key: key,
      child: Column(
        children: [
          SizedBox(
            height: height * .3,
          ),
          SizedBox(
            height: height * .1,
            child: const Align(
              alignment: Alignment(-.85, 0),
              child: Text(
                'Login',
                style: TextStyle(
                    color: Color.fromARGB(255, 7, 118, 230),
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                    letterSpacing: 1),
              ),
            ),
          ),
          SizedBox(
            height: height * .1,
            child: Padding(
              padding: const EdgeInsets.only(
                left: 25,
                right: 25,
              ),
              child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'must enter username';
                    }
                    return null;
                  },
                  controller: userNameController,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    suffixIcon: text.isEmpty
                        ? const SizedBox(
                            width: 0,
                            height: 0,
                          )
                        : IconButton(
                            onPressed: () {
                              userNameController.clear();
                            },
                            icon: const Icon(
                              Icons.clear,
                              color: Colors.blue,
                              size: 20,
                            )),
                    contentPadding: EdgeInsets.only(top: 20),
                    hintText: 'Username',
                    hintStyle: TextStyle(fontSize: 15),
                  )),
            ),
          ),
          SizedBox(
            height: height * .1,
            child: Padding(
              padding: const EdgeInsets.only(
                left: 25,
                right: 25,
              ),
              child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'must enter password';
                    }
                    return null;
                  },
                  controller: passwordControlelr,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: isNotVisible,
                  decoration: InputDecoration(
                    suffixIcon: isNotVisible
                        ? IconButton(
                            onPressed: () {
                              setState(() {
                                isNotVisible = false;
                              });
                            },
                            icon: const Icon(
                              Icons.visibility_off,
                              size: 20,
                            ))
                        : IconButton(
                            onPressed: () {
                              setState(() {
                                isNotVisible = true;
                              });
                            },
                            icon: const Icon(
                              Icons.visibility,
                               size: 20,
                            )),
                    contentPadding: const EdgeInsets.only(top: 20),
                    hintText: 'Password',
                    hintStyle: const TextStyle(fontSize: 15),
                  )),
            ),
          ),
          //forgotPasword
          SizedBox(
            height: height * .05,
            child: const Padding(
              padding: const EdgeInsets.only(right: 25.0),
              child: Align(
                alignment: Alignment.topRight,
                child: Text(
                  'Forgot password',
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          //login Button
          SizedBox(
            height: height * .12,
            child: Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Button(callback: LoginClick, text: 'Login'),
                )),
          ),
          //already have account
          SizedBox(
            height: height * .05,
            child: Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: Text.rich(TextSpan(
                    text: 'Don\'t have an account? ',
                    style: const TextStyle(
                        fontSize: 11,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold),
                    children: [
                      TextSpan(
                          text: 'Sign up',
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return RegisterationPage();
                                },
                              ));
                            },
                          style: const TextStyle(
                              color: Colors.blue,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline))
                    ])),
              ),
            ),
          ),
          SizedBox(
            height: height * .18,
          ),
        ],
      ),
    );
  }

  void LoginClick() {
    if (key.currentState!.validate()) {
      setState(() {
        String userName = userNameController.text;
        String password = passwordControlelr.text;
        print('$userName  $password');

        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return Show();
          },
        ));
        userNameController.clear();
        passwordControlelr.clear();
      });
    }
  }
}

class Button extends StatelessWidget {
  final VoidCallback callback;
  final String text;
  const Button({required this.callback, required this.text, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      //color: Colors.red,
      borderRadius: BorderRadius.circular(20),
      child: Ink(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: const LinearGradient(
                colors: [Colors.red, Colors.orange],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                stops: [.3, .9])),
        child: InkWell(
          onTap: callback,
          child: SizedBox(
            width: 160,
            height: 40,
            child: Center(
              child: Text(
                text,
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ClipTopShape extends CustomClipper<Path> {
  double firstEndPointWidth;

  ClipTopShape(this.firstEndPointWidth);
  @override
  Path getClip(Size size) {
    double height = size.height;
    double width = size.width;
    Path path = new Path();
    //path.lineTo(0, height * .05);
    path.lineTo(width * .1, height * .04);
    //path.lineTo(width * .4, height * .1);
    path.quadraticBezierTo(
        width * .6, height * .15, width * firstEndPointWidth, height * .4);
    path.quadraticBezierTo(width * .7, height * .8, width, height * .7);

    path.lineTo(width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    if (oldClipper != this) {
      return true;
    }
    return false;
  }
}

class ClipBottomShaape extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double height = size.height;
    double width = size.width;
    Path path = new Path();
    path.lineTo(0, height);
    path.lineTo(width, height);
    path.lineTo(width, height * .3);
    path.quadraticBezierTo(width * .25, height, 0, height * .1);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    if (oldClipper != this) {
      return true;
    }
    return false;
  }
}

class ClipBottomhapeSec extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double height = size.height;
    double width = size.width;
    Path path = Path();
    path.lineTo(0, height);
    path.lineTo(
      width,
      height,
    );
    // path.lineTo(width * .7, height * .9);
    //path.lineTo(x, y)
    //
    path.quadraticBezierTo(width * .3, height * .8, width * .3, height * .6);
    path.quadraticBezierTo(width * .35, height * .1, 0, height * .1);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    if (oldClipper != this) {
      return true;
    }
    return false;
  }
}
