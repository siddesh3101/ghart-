import 'package:flutter/material.dart';

class OnboardingPage2 extends StatelessWidget {
  const OnboardingPage2({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(25, 70, 25, 20),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          SizedBox(
            height: 30,
          ),
          Image(image: AssetImage('assets/eventi.jpg')),
          SizedBox(
            height: 150,
          ),
          Text(
            'Swipe your way',
            style: TextStyle(fontSize: 25),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "Swipe your way to social change! Find like-minded activists and rallies near you.",
            style: TextStyle(fontSize: 16, fontFamily: 'Poppins'),
          )
        ],
      ),
    );
  }
}
