import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:login_ui/pages/login_page.dart';

class RegisterationPage extends StatelessWidget {
  const RegisterationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        primary: true,
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.manual,
        dragStartBehavior: DragStartBehavior.start,
        scrollDirection: Axis.vertical,
        reverse: false,
        restorationId: 'key',
        child: Stack(
          children: [
            const TopBottomClipShape(),
            const TopUpperClipShape(),
            Registeration(
              height: height,
              width: width,
            ),
            const BottomDownClipShape(),
            const BottomUpClipShape(),
          ],
        ),
      ),
    );
  }
}

class Registeration extends StatefulWidget {
  final double height;
  final double width;
  const Registeration({required this.height, required this.width, Key? key})
      : super(key: key);

  @override
  State<Registeration> createState() =>
      _RegisterationState(height: height, width: width);
}

class _RegisterationState extends State<Registeration> {
  double height;
  double width;
  String name = '';
  String mobile = '';
  String userName = '';
  bool isObsecure = true;
  late TextEditingController nameController;
  late TextEditingController passwordController;
  late TextEditingController userNameController;
  late TextEditingController mobileNumController;
  GlobalKey<FormState> validationKey = GlobalKey();

  @override
  void initState() {
    nameController = TextEditingController();
    passwordController = TextEditingController();
    userNameController = TextEditingController();
    mobileNumController = TextEditingController();
    nameController.addListener(() {
      setState(() {
        name = nameController.text;
      });
    });
    userNameController.addListener(() {
      setState(() {
        userName = userNameController.text;
      });
    });
    mobileNumController.addListener(() {
      setState(() {
        mobile = mobileNumController.text;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    passwordController.dispose();
    mobileNumController.dispose();
    userNameController.dispose();
  }

  _RegisterationState({required this.height, required this.width});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: validationKey,
      child: Column(
        children: [
          SizedBox(
            height: height * .25,
          ),
          SizedBox(
            height: height * .05,
            child: const Align(
              alignment: Alignment(-.85, 0),
              child: Text(
                'Register',
                style: TextStyle(
                    color: Color.fromARGB(255, 6, 130, 231),
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          //name
          SizedBox(
            height: height * .1,
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: TextFormField(
                controller: nameController,
                validator: (String? value) {
                  if (nameController.text.isEmpty) {
                    return 'can\'t be empty';
                  }
                  return null;
                },
                decoration: InputDecoration(
                    hintText: 'Name',
                    hintStyle: TextStyle(fontSize: 15),
                    suffixIcon: name.isEmpty
                        ? Container(
                            width: 0,
                            height: 0,
                          )
                        : IconButton(
                            onPressed: () {
                              setState(() {
                                nameController.clear();
                              });
                            },
                            icon: const Icon(
                              Icons.clear,
                              size: 20,
                            )),
                    contentPadding: EdgeInsets.only(top: 15)),
              ),
            ),
          ),
          //mobile
          SizedBox(
            height: height * .1,
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: TextFormField(
                controller: mobileNumController,
                validator: (String? value) {
                  if (mobileNumController.text.isEmpty) {
                    return 'can\'t be empty';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hintText: 'Mobile Number',
                  hintStyle: TextStyle(fontSize: 15),
                  suffixIcon: mobile.isEmpty
                      ? Container(
                          width: 0,
                          height: 0,
                        )
                      : IconButton(
                          onPressed: () {
                            setState(() {
                              mobileNumController.clear();
                            });
                          },
                          icon: const Icon(
                            Icons.clear,
                            size: 20,
                          )),
                  contentPadding: EdgeInsets.only(top: 15),
                ),
                keyboardType: TextInputType.phone,
              ),
            ),
          ),
          //userName
          SizedBox(
            height: height * .1,
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: TextFormField(
                controller: userNameController,
                validator: (String? value) {
                  if (userNameController.text.isEmpty) {
                    return 'can\'t be empty';
                  }
                  return null;
                },
                decoration: InputDecoration(
                    hintText: 'Username',
                    hintStyle: TextStyle(fontSize: 15),
                    suffixIcon: userName.isEmpty
                        ? Container(
                            width: 0,
                            height: 0,
                          )
                        : IconButton(
                            onPressed: () {
                              setState(() {
                                userNameController.clear();
                              });
                            },
                            icon: const Icon(
                              Icons.clear,
                              size: 20,
                            )),
                    contentPadding: EdgeInsets.only(top: 15)),
              ),
            ),
          ),
          //Password
          SizedBox(
            height: height * .1,
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: TextFormField(
                controller: passwordController,
                validator: (String? value) {
                  String password = passwordController.text;
                  if (password.isEmpty) {
                    return 'can\'t be empty';
                  } else if (password.length < 7) {
                    return 'length should be>7';
                  }
                  return null;
                },
                obscureText: isObsecure,
                decoration: InputDecoration(
                  hintText: 'Password',
                  contentPadding: EdgeInsets.only(top: 15),
                  hintStyle: TextStyle(fontSize: 15),
                  suffixIcon: isObsecure
                      ? IconButton(
                          onPressed: () {
                            setState(() {
                              isObsecure = false;
                            });
                          },
                          icon: const Icon(
                            Icons.visibility_off,
                            size: 20,
                          ))
                      : IconButton(
                          onPressed: () {
                            setState(() {
                              isObsecure = true;
                            });
                          },
                          icon: Icon(
                            Icons.visibility,
                            size: 20,
                          )),
                ),
              ),
            ),
          ),

          SizedBox(
            height: height * .05,
            child: Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: Button(callback: SignUpClick, text: 'SIGN UP'),
              ),
            ),
          ),
          SizedBox(
            height: height * .05,
            child: Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: EdgeInsets.only(right: 20),
                child: Text.rich(TextSpan(
                  text: 'Already have an account? ',
                  style: const TextStyle(
                      color: Colors.blue,
                      fontSize: 11,
                      fontWeight: FontWeight.w500),
                  children: [
                    TextSpan(
                        text: 'Sign in',
                        style: const TextStyle(
                            color: Colors.blue,
                            fontSize: 12,
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.w700),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Sign in page')));
                          })
                  ],
                )),
              ),
            ),
          ),
          SizedBox(
            height: height * .2,
          ),
        ],
      ),
    );
  }

  void SignUpClick() {
    if (validationKey.currentState!.validate()) {
      String name = nameController.text;
      String password = passwordController.text;
      String userName = userNameController.text;
      String mobileNum = mobileNumController.text;
      setState(() {});
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('not validated')));
    }
  }
}

class TopBottomClipShape extends StatelessWidget {
  const TopBottomClipShape({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return ClipPath(
      clipper: ClipTopShape(6 / 10.0),
      child: Container(
        height: height * .3,
        width: width,
        color: Colors.blue,
      ),
    );
  }
}

class TopUpperClipShape extends StatelessWidget {
  const TopUpperClipShape({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return ClipPath(
      clipper: ClipTopShape(6 / 10.0),
      child: Container(
        height: height * .35,
        width: width,
        color: Colors.blue.withOpacity(.5),
      ),
    );
  }
}

class BottomDownClipShape extends StatelessWidget {
  const BottomDownClipShape({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.max,
      children: [
        SizedBox(
          height: height * .85,
        ),
        SizedBox(
          child: ClipPath(
            clipper: ClipBottomShaape(),
            child: Container(
              color: Colors.blue.withOpacity(.4),
            ),
          ),
          height: height * .15,
        )
      ],
    );
  }
}

class BottomUpClipShape extends StatelessWidget {
  const BottomUpClipShape({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.max,
      children: [
        SizedBox(
          height: height * .75,
        ),
        SizedBox(
          child: ClipPath(
            clipper: ClipBottomhapeSec(),
            child: Container(
              color: Colors.blue.withOpacity(.6),
            ),
          ),
          height: height * .25,
        )
      ],
    );
  }
}
