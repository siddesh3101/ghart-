import 'package:flutter/material.dart';
import 'package:flutter_hackathon/constants/colors.dart';
import 'package:flutter_hackathon/screens/login_screen.dart';
import 'package:flutter_hackathon/screens/main_screen.dart';
import 'package:flutter_hackathon/screens/onboarding/onboarding1.dart';
import 'package:flutter_hackathon/screens/onboarding/onboarding2.dart';
import 'package:flutter_hackathon/screens/onboarding/onboarding3.dart';

class OnboardingPage extends StatefulWidget {
  static const routeName = '/onboardingpage';
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _controller = PageController();

  bool onLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                onLastPage = (index == 2);
              });
            },
            children: const [
              OnboardingPage1(),
              OnboardingPage2(),
              OnBoardingPage3()
            ],
          ),
          Container(
              padding: const EdgeInsets.all(20),
              alignment: const Alignment(0, 0.75),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  onLastPage
                      ? GestureDetector(
                          onTap: () {
                            _controller.nextPage(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeIn);
                          },
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: MyColors.primaryColor),
                            onPressed: () {
                              const Duration(milliseconds: 1000);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LoginScreen(),
                                  ));
                            },
                            child: const Text(
                              'Start',
                            ),
                          ))
                      : GestureDetector(
                          onTap: () {
                            _controller.nextPage(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeIn);
                          },
                          child: Row(
                            children: const [
                              Text(
                                'Next',
                                style: TextStyle(color: Colors.black),
                              ),
                              Icon(Icons.navigate_next_rounded),
                            ],
                          ),
                        )
                ],
              ))
        ],
      ),
    );
  }
}
