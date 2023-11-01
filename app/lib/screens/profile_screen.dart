import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hackathon/constants/colors.dart';
import 'package:flutter_hackathon/screens/category_screen.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? image;
  final List<Map> sliders1 = [
    {
      'image': 'assets/images/social.png',
      'category': 'Social',
      'color': Color(0xFFF0635A)
    },
    {
      'image': 'assets/images/rally.png',
      'category': 'Rally',
      'color': Color(0xFFF59762)
    },
    {
      'image': 'assets/images/speaker.png',
      'category': 'Conference',
      'color': Color(0xFF29D697)
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'Profile Screen',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 15,
          ),
          GestureDetector(
            onTap: () async {
              final image =
                  await ImagePicker().pickImage(source: ImageSource.gallery);
              if (image != null) {
                setState(() => this.image = File(image.path));
              }
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                if (image == null)
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      height: 100,
                      width: 100,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFFDFDDEA),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.person_outline_rounded,
                          color: MyColors.primaryColor,
                        ),
                      ),
                    ),
                  )
                else
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: image != null
                            ? DecorationImage(
                                image: FileImage(image!),
                                fit: BoxFit.cover,
                              )
                            : null,
                      ),
                    ),
                  ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  left: 50,
                  child: Container(
                    height: 30,
                    width: 30,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: const Center(
                      child: Icon(Icons.camera_alt, size: 15),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: Column(
                  children: [
                    Text(
                      '12',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Events Attended',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(color: Colors.black),
                    ),
                  ],
                )),
                Expanded(
                    child: Column(
                  children: [
                    Text(
                      '7',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Events Volunteered',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(color: Colors.black),
                    ),
                  ],
                )),
              ],
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Image.asset(
              'assets/editprofile.png',
              width: 120,
              height: 120,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              'About Me',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              'I am siddesh shetty from thadomal shahani engineerin college.I am siddesh shetty from thadomal shahani engineerin college',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.black,
                  ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Row(
              children: [
                Text(
                  'Interests',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                Spacer(),
                Image.asset(
                  'assets/change.png',
                  width: 100,
                )
              ],
            ),
          ),
          Container(
            alignment: Alignment.center,
            height: 50,
            width: 300,
            child: ListView.builder(
              itemCount: sliders1.length,
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CategoryScreen(
                                  category: sliders1[index]['category']
                                      .toString()
                                      .toLowerCase(),
                                )));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      alignment: Alignment.center,
                      height: 10,
                      decoration: BoxDecoration(
                          color: sliders1[index]['color'],
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Image.asset(
                              sliders1[index]['image'],
                              width: 20,
                              height: 20,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              sliders1[index]['category'],
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall
                                  ?.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
