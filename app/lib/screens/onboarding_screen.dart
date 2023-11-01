import 'package:concentric_transition/concentric_transition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hackathon/constants/colors.dart';

class OnboaardingScreen extends StatefulWidget {
  const OnboaardingScreen({super.key});

  @override
  State<OnboaardingScreen> createState() => _OnboaardingScreenState();
}

class _OnboaardingScreenState extends State<OnboaardingScreen> {
  @override
  Widget build(BuildContext context) {
    // List<IntroScreen> _list = [
    //   IntroScreen(
    //     title: 'Grow with Vruksha',
    //     imageAsset: 'assets/images/ob1.png',
    //     description: 'A vitual garfdening platform for urban planters',
    //     headerBgColor: Colors.white,
    //   ),
    //   IntroScreen(
    //     title: 'Analyze your garden',
    //     headerBgColor: Colors.white,
    //     imageAsset: 'assets/images/ob2.png',
    //     description: "With our technology, you can analyze your garden",
    //   ),
    //   IntroScreen(
    //     title: 'Remote Garden',
    //     headerBgColor: Colors.white,
    //     imageAsset: 'assets/images/ob3.png',
    //     description: "You can control your garden from anywhere",
    //   ),
    //   IntroScreen(
    //     title: 'Go Green!',
    //     headerBgColor: Colors.white,
    //     imageAsset: 'assets/images/ob4.png',
    //     description: "Sign up, to start your green journey",
    //   ),
    // ];
    // IntroScreens introScreens = IntroScreens(
    //   footerBgColor: MyColors.primaryColor,
    //   activeDotColor: Colors.white,
    //   textColor: Colors.white,
    //   footerRadius: 18.0,
    //   indicatorType: IndicatorType.CIRCLE,
    //   slides: _list,
    //   onDone: () {
    //     Navigator.pushReplacementNamed(context, '/oblocation');
    //   },
    // );
    return Scaffold(
      body: SafeArea(
          child: ConcentricPageView(
        colors: <Color>[Colors.white, Colors.blue, Colors.red],
        itemCount: 3, // null = infinity
        physics: NeverScrollableScrollPhysics(),
        onChange: (page) => {
          if (page == 2)
            {
              // Navigator.pushReplacementNamed(context, '/oblocation')
            }
        },
        itemBuilder: (int pos) {
          return Center(
            child: Container(
              child: Text('Page $pos'),
            ),
          );
        },
      )),
    );
  }
}
