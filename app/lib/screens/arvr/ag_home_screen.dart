import 'package:flutter/material.dart';
import 'package:flutter_hackathon/screens/arvr/agent/services/create_ad.dart';
import 'package:flutter_hackathon/screens/arvr/details/detail_screen.dart';
import 'package:flutter_hackathon/screens/arvr/details/models/facility.dart';
import 'package:flutter_hackathon/screens/arvr/details/models/hotels.dart';

final Hotel dummyHotel = Hotel(
  id: 1,
  name: 'Sample Hotel',
  description: 'A cozy hotel with great amenities.',
  location: '123 Main Street',
  rate: 4.5,
  price: 150.0,
  admin: 'Admin User',
  numberRooms: 50,
  facilities: [
    Facility(
        icon: 'https://www.svgrepo.com/show/532033/cloud.svg',
        id: 1,
        name: 'Gym'),
    Facility(
        icon: 'https://www.svgrepo.com/show/532033/cloud.svg',
        id: 2,
        name: 'Swimming')
  ],
  images: [
    HotelImage(
        id: 1,
        name: 'Smirti Palace',
        path:
            'https://images.pexels.com/photos/439391/pexels-photo-439391.jpeg?auto=compress&cs=tinysrgb&w=600'),
    HotelImage(
        id: 2,
        name: 'Smirti Palace',
        path:
            'https://images.pexels.com/photos/439391/pexels-photo-439391.jpeg?auto=compress&cs=tinysrgb&w=600')
  ],
);

class AGHomeScreen extends StatefulWidget {
  const AGHomeScreen({super.key});

  @override
  State<AGHomeScreen> createState() => _AGHomeScreenState();
}

class _AGHomeScreenState extends State<AGHomeScreen> {
  final List<String> chipData = ['All', 'House', 'Villa', 'Apartment'];
  late final Map<dynamic, dynamic> data;

  @override
  void initState() {
    super.initState();
  }

  void getData() async {
    data = await CreateAd().getItenirary();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  CircleAvatar(
                    radius: 25.0,
                    backgroundImage:
                        NetworkImage('https://via.placeholder.com/150'),
                    backgroundColor: Colors.transparent,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text('Good Morning '),
                          Image.asset(
                            'assets/waving.png',
                            width: 20,
                            height: 20,
                          )
                        ],
                      ),
                      Text(
                        'Siddesh Shetty',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17),
                      )
                    ],
                  ),
                  Spacer(),
                  Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, border: Border.all(width: 1)),
                    width: 45,
                    height: 45,
                    alignment: Alignment.center,
                    child: Image.asset(
                      'assets/noti.png',
                      width: 25,
                      height: 25,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 25,
              ),
              Container(
                width: double.infinity,
                height: 70,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 236, 236, 236),
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 12, right: 12, top: 8, bottom: 8),
                  child: Row(children: [
                    Icon(Icons.search),
                    SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: 100,
                      child: TextFormField(
                        onChanged: (text) {},
                        onFieldSubmitted: (text) {},
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: InputDecoration(
                          enabledBorder: border,
                          hintText: 'Search',
                          hintStyle:
                              TextStyle(color: Colors.grey, fontSize: 18),
                          border: border,
                          focusedBorder: border,
                          errorBorder: errorBorder,
                          focusedErrorBorder: errorBorder,
                        ),
                      ),
                    ),
                    Spacer(),
                    Image.asset(
                      'assets/filter.png',
                      width: 25,
                      height: 25,
                    ),
                  ]),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    spacing: 8.0, // Space between chips
                    runSpacing: 8.0, // Space between chip rows
                    children: chipData.map((String label) {
                      return Chip(
                        backgroundColor: Colors.transparent,
                        avatar: Image.asset(
                          'assets/${label.toLowerCase()}.png',
                          width: 15,
                          height: 15,
                        ),
                        shape: StadiumBorder(side: BorderSide()),

                        label: Text(label),
                        // onDeleted: () {
                        //   // Handle chip deletion here
                        // },
                      );
                    }).toList(),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Text(
                        'Featured Properties',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17),
                      ),
                      Spacer(),
                      Text(
                        'See All',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    height: 250,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => DetailsView(
                                    hotel: dummyHotel, usingHero: true),
                              ));
                            },
                            child: Container(
                              width: 200,
                              height: 300,
                              decoration: BoxDecoration(
                                  // color: Colors.amber,
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                          'https://images.pexels.com/photos/439391/pexels-photo-439391.jpeg?auto=compress&cs=tinysrgb&w=600'))),
                              child: Stack(
                                // crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Positioned(
                                    bottom: 22,
                                    left: 5,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Sterlin Apartment',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 17),
                                        ),
                                        Text(
                                          'Sector A Kanpur',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 17),
                                        ),
                                        Text(
                                          '${29}/M',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 17),
                                        )
                                      ],
                                    ),
                                  ),
                                  Positioned(
                                    right: 5,
                                    top: 5,
                                    child: Container(
                                      // width: 50,
                                      // height: 50,
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Row(
                                          children: [
                                            Image.asset(
                                              'assets/star.png',
                                              width: 15,
                                              height: 15,
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              '4.8',
                                              style: TextStyle(
                                                  color: Colors.blue[900]),
                                            ),
                                          ],
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                          color: Color.fromARGB(
                                              255, 241, 248, 255),
                                          borderRadius:
                                              BorderRadius.circular(7)),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text(
                        'Trending Properties near you',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17),
                      ),
                      Spacer(),
                      Text(
                        'See All',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    height: 250,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 200,
                            height: 300,
                            decoration: BoxDecoration(
                                // color: Colors.amber,
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                        'https://images.pexels.com/photos/439391/pexels-photo-439391.jpeg?auto=compress&cs=tinysrgb&w=600'))),
                            child: Stack(
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Positioned(
                                  bottom: 22,
                                  left: 5,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Sterlin Apartment',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17),
                                      ),
                                      Text(
                                        'Sector A Kanpur',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17),
                                      ),
                                      Text(
                                        '${29}/M',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17),
                                      )
                                    ],
                                  ),
                                ),
                                Positioned(
                                  right: 5,
                                  top: 5,
                                  child: Container(
                                    // width: 50,
                                    // height: 50,
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Row(
                                        children: [
                                          Image.asset(
                                            'assets/star.png',
                                            width: 15,
                                            height: 15,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            '4.8',
                                            style: TextStyle(
                                                color: Colors.blue[900]),
                                          ),
                                        ],
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                        color:
                                            Color.fromARGB(255, 241, 248, 255),
                                        borderRadius: BorderRadius.circular(7)),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              )
            ],
          ),
        ),
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

final border = InputBorder.none;

final errorBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(12),
  borderSide: const BorderSide(color: Colors.red),
);
