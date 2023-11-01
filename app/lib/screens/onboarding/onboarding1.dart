import 'package:flutter/material.dart';

class OnboardingPage1 extends StatelessWidget {
  const OnboardingPage1({super.key});

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
            'Join the movement',
            style: TextStyle(fontSize: 25),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Join the movement, not just the app. Swipe right to stand up for what matters.',
            style: TextStyle(fontSize: 16, fontFamily: 'Poppins'),
          )
        ],
      ),
    );
  }
}
