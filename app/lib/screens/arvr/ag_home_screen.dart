import 'package:flutter/material.dart';

class AGHomeScreen extends StatefulWidget {
  const AGHomeScreen({super.key});

  @override
  State<AGHomeScreen> createState() => _AGHomeScreenState();
}

class _AGHomeScreenState extends State<AGHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          topBar(),
        ],
      ),
    ));
  }
}

Widget topBar() {
  return Container(
    height: 100,
    width: double.infinity,
    color: Colors.white,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [Image.asset('assets/user.jpg')],
    ),
  );
}
