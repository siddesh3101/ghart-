import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hackathon/constants/colors.dart';
import 'package:flutter_hackathon/screens/loader.dart';
import 'package:flutter_hackathon/screens/main_screen.dart';
import 'package:flutter_hackathon/services/get_events.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

class LoginScreen extends StatefulWidget {
  static const nameRoute = '/loginpage';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  bool _passwordInVisible = true;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool loading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Future<void> _firebaseLoginAuth() async {
  //   setState(() {
  //     loading = true;
  //   });
  //   if (_formKey.currentState!.validate()) {
  //     try {
  //       await FirebaseAuth.instance
  //           .signInWithEmailAndPassword(
  //             email: _emailController.text.trim(),
  //             password: _passwordController.text.trim(),
  //           )
  //           .then((value) => showDialog(
  //               context: context,
  //               builder: (BuildContext context) {
  //                 return AlertDialog(
  //                   content: const Text(
  //                     'Login was succesful!',
  //                     style: TextStyle(fontSize: 20),
  //                   ),
  //                   actions: <Widget>[
  //                     ElevatedButton(
  //                       style: ElevatedButton.styleFrom(
  //                           backgroundColor: Colors.green),
  //                       child: const Text('Explore'),
  //                       onPressed: () {
  //                         const Duration(milliseconds: 500);
  //                         Navigator.push(
  //                             context,
  //                             MaterialPageRoute(
  //                                 builder: (context) =>
  //                                     const UserPreferencesPage()));
  //                       },
  //                     ),
  //                   ],
  //                 );
  //               }));
  //     } on FirebaseAuthException catch (e) {
  //       showNotification(context, e.message.toString());
  //     }
  //     setState(() {
  //       loading = false;
  //     });
  //   } else {
  //     setState(() {
  //       loading = false;
  //     });
  //   }
  // }

  void showNotification(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.redAccent, content: Text(message.toString())));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: size.width,
          height: size.height,
          child: SingleChildScrollView(
            child: Stack(
              children: [
                const Upside(
                  imgUrl: "assets/event.png",
                ),
                const PageTitleBar(title: 'Hello, Welcome Back'),
                Padding(
                  padding: const EdgeInsets.only(top: 320.0),
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          "Login below with your details",
                          style: TextStyle(
                              color: Colors.grey,
                              fontFamily: 'OpenSans',
                              fontSize: 13,
                              fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              TextFieldContainer(
                                child: TextFormField(
                                  controller: _emailController,
                                  cursorColor: MyColors.primaryColor,
                                  decoration: const InputDecoration(
                                      icon: Icon(
                                        Icons.person,
                                        color: MyColors.primaryColor,
                                      ),
                                      hintText: 'Email',
                                      hintStyle:
                                          TextStyle(fontFamily: 'OpenSans'),
                                      border: InputBorder.none),
                                  validator: Validators.compose([
                                    Validators.required(
                                        'Email address is required'),
                                    Validators.email('Please input valid email')
                                  ]),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextFieldContainer(
                                child: TextFormField(
                                  controller: _passwordController,
                                  obscureText: _passwordInVisible,
                                  cursorColor: MyColors.primaryColor,
                                  decoration: InputDecoration(
                                      icon: const Icon(
                                        Icons.lock,
                                        color: MyColors.primaryColor,
                                      ),
                                      hintText: "Password",
                                      hintStyle: const TextStyle(
                                          fontFamily: 'OpenSans'),
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          _passwordInVisible
                                              ? Icons.visibility_off
                                              : Icons.visibility,
                                          color: MyColors.primaryColor,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _passwordInVisible =
                                                !_passwordInVisible;
                                          });
                                        },
                                      ),
                                      border: InputBorder.none),
                                  validator: Validators.compose([
                                    Validators.required('Password is required'),
                                  ]),
                                ),
                              ),
                              Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(context, '/');
                                    },
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: const [
                                        Text('Forgot Password?',
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontWeight: FontWeight.bold))
                                      ],
                                    ),
                                  )),
                              const SizedBox(
                                height: 10,
                              ),
                              loading
                                  ? const CircularProgressIndicator()
                                  : RoundedButton(
                                      text: 'LOGIN',
                                      press: () async {
                                        AppLoader.showLoader(context);
                                        await EventsService()
                                            .login(_emailController.text);
                                        AppLoader.hideLoader(context);
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    MainPage()));
                                      }),
                              const SizedBox(
                                height: 10,
                              ),
                              UnderPart(
                                title: "Don't have an account?",
                                navigatorText: "Register here",
                                onTap: () {
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (context) =>
                                  //             const MainPage()));
                                },
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Upside extends StatelessWidget {
  const Upside({Key? key, required this.imgUrl}) : super(key: key);
  final String imgUrl;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          width: size.width,
          height: size.height / 3,
          alignment: Alignment.center,
          color: Colors.white,
          // decoration: const BoxDecoration(
          //   image: DecorationImage(
          //       image: AssetImage('assets/event.png'), fit: BoxFit.fitHeight),
          // ),
          child: Image.asset(
            'assets/event.png',
            width: 200,
            height: 100,
          ),
        ),
      ],
    );
  }
}

iconBackButton(BuildContext context) {
  return IconButton(
    color: Colors.white,
    iconSize: 28,
    icon: const Icon(CupertinoIcons.arrow_left),
    onPressed: () {
      Navigator.pop(context);
    },
  );
}

class PageTitleBar extends StatelessWidget {
  const PageTitleBar({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 260.0),
      child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height / 4,
        decoration: BoxDecoration(
          color: MyColors.primaryColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50),
            topRight: Radius.circular(50),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 20,
                letterSpacing: 1,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class TextFieldContainer extends StatelessWidget {
  const TextFieldContainer({Key? key, this.child}) : super(key: key);
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: size.width * 0.8,
      decoration: BoxDecoration(
        color: const Color(0xfffeeeee4),
        borderRadius: BorderRadius.circular(29),
      ),
      child: child,
    );
  }
}

class RoundedButton extends StatelessWidget {
  const RoundedButton(
      {Key? key, this.press, this.textColor = Colors.white, required this.text})
      : super(key: key);
  final String text;
  final Function()? press;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.8,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child: newElevatedButton(),
      ),
    );
  }

  Widget newElevatedButton() {
    return ElevatedButton(
      onPressed: press,
      style: ElevatedButton.styleFrom(
          primary: MyColors.primaryColor,
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          textStyle: TextStyle(
              letterSpacing: 2,
              color: textColor,
              fontSize: 12,
              fontWeight: FontWeight.bold,
              fontFamily: 'OpenSans')),
      child: Text(
        text,
        style: TextStyle(color: textColor, fontSize: 17),
      ),
    );
  }
}

class UnderPart extends StatelessWidget {
  const UnderPart(
      {Key? key,
      required this.title,
      required this.navigatorText,
      required this.onTap})
      : super(key: key);
  final String title;
  final String navigatorText;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: const TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 13,
              color: Colors.grey,
              fontWeight: FontWeight.w600),
        ),
        const SizedBox(
          width: 20,
        ),
        InkWell(
          onTap: () {
            onTap();
          },
          child: Text(
            navigatorText,
            style: const TextStyle(
                color: MyColors.primaryColor,
                fontSize: 13,
                fontWeight: FontWeight.w600,
                fontFamily: 'Opensans'),
          ),
        )
      ],
    );
  }
}
