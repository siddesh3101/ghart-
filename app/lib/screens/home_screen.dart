import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hackathon/constants.dart';
import 'package:flutter_hackathon/screens/category_screen.dart';
import 'package:flutter_hackathon/screens/event_detail_screen.dart';
import 'package:flutter_hackathon/services/get_events.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> slid = [];
  List<dynamic> slid1 = [];
  bool loading = true;
  final List<String> sliders = [
    'assets/image1.jpg',
    'assets/image2.jpg',
    'assets/image3.jpg',
  ];
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
  void fetchData() async {
    try {
      // Replace EventsService().getItinerary() with your data fetching logic here
      final data = await EventsService().getItinerary();

      setState(() {
        slid = data['data'];
        slid1 = data['data1'];
        loading = false;
      });
    } catch (error) {
      throw error;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    fetchData();
    super.initState();
  }

  int _selectedSlider = 0;

//social marathon rally
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              // margin: const EdgeInsets.only(bottom: kDefaultPadding * 2.5),
              // It will cover 20% of our total height
              // color: Colors.black,
              height: size.height * 0.22,
              child: Stack(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.only(
                      left: kDefaultPadding,
                      right: kDefaultPadding,
                      bottom: 90 + kDefaultPadding,
                    ),
                    height: size.height * 0.23 - 27,
                    decoration: const BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(36),
                        bottomRight: Radius.circular(36),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            // Navigator.of(context).pushNamed('/profile');
                          },
                          child: const Icon(
                            Icons.menu,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Row(
                          children: [
                            Text(
                              'Current Location',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall
                                  ?.copyWith(
                                      color: Colors.white.withOpacity(0.5),
                                      fontWeight: FontWeight.bold),
                            ),
                            const Icon(
                              Icons.arrow_drop_down,
                              color: Colors.white,
                            )
                          ],
                        ),
                        Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white.withOpacity(0.1)),
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Icon(
                              Icons.notifications,
                              color: Colors.white,
                            ),
                          ),
                        )
                        // Spacer(),
                      ],
                    ),
                  ),

                  Positioned(
                    top: 60,
                    left: 5,
                    right: 0,
                    child: Container(
                      margin: EdgeInsets.all(10),
                      child: GestureDetector(
                        onTap: () => Navigator.pushNamed(context, '/search'),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            const Icon(
                              Icons.search,
                              color: Colors.white,
                            ),
                            Text(
                              '| ',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall
                                  ?.copyWith(
                                      color: Colors.white.withOpacity(0.5),
                                      fontWeight: FontWeight.bold),
                            ),
                            Row(
                              children: [
                                Text(
                                  'Search..',
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge
                                      ?.copyWith(
                                          color: Colors.white.withOpacity(0.5),
                                          fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Spacer(),
                            InkWell(
                              onTap: () {
                                Navigator.of(context)
                                    .pushNamed('/notification');
                              },
                              child: SvgPicture.asset(
                                  'assets/images/filter.svg',
                                  height: 32,
                                  width: 25),
                            )
                            // Spacer(),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: kDefaultPadding + 175,
                        right: kDefaultPadding,
                        top: 35),
                    child: Text(
                      'Mumbai',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),

                  //
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      alignment: Alignment.center,
                      height: 50,
                      width: 100,
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
                                            category: sliders1[index]
                                                    ['category']
                                                .toString()
                                                .toLowerCase(),
                                          )));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
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
                    // child: Container(
                    //   alignment: Alignment.center,
                    //   margin:
                    //       const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                    //   padding:
                    //       const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                    //   height: 54,
                    //   decoration: BoxDecoration(
                    //     color: Colors.white,
                    //     borderRadius: BorderRadius.circular(20),
                    //     boxShadow: [
                    //       BoxShadow(
                    //         offset: const Offset(0, 10),
                    //         blurRadius: 50,
                    //         color: kPrimaryColor.withOpacity(0.23),
                    //       ),
                    //     ],
                    //   ),
                    //   child: Row(
                    //     children: <Widget>[
                    //       Expanded(
                    //         child: TextField(
                    //           onChanged: (value) {},
                    //           decoration: InputDecoration(
                    //             hintText: "Search",
                    //             hintStyle: TextStyle(
                    //               color: kPrimaryColor.withOpacity(0.5),
                    //             ),
                    //             enabledBorder: InputBorder.none,
                    //             focusedBorder: InputBorder.none,
                    //             // surffix isn't working properly  with SVG
                    //             // thats why we use row
                    //             // suffixIcon: SvgPicture.asset("assets/icons/search.svg"),
                    //           ),
                    //         ),
                    //       ),
                    //       // Image.asset("assets/icons/search.svg"),
                    //     ],
                    //   ),
                    // ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Column(
              children: [
                CarouselSlider(
                  items: sliders.map((e) {
                    return Card(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      color: Colors.grey[200],
                      child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                          child: Image.asset(e, fit: BoxFit.cover)),
                    );
                  }).toList(),
                  options: CarouselOptions(
                      aspectRatio: 2.00,
                      autoPlay: true,
                      onPageChanged: (idx, _) =>
                          {setState(() => _selectedSlider = idx)}),
                ),
                DotsIndicator(
                    dotsCount: sliders.length,
                    position: _selectedSlider,
                    decorator: const DotsDecorator(
                        color: Colors.grey, activeColor: Colors.blue)),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: kDefaultPadding,
                  right: kDefaultPadding,
                  top: kDefaultPadding,
                  bottom: 10),
              child: Row(
                children: [
                  Text(
                    'Upcoming Events',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  Text(
                    'See All',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: Colors.black.withOpacity(0.5),
                        fontWeight: FontWeight.bold),
                  ),
                  Icon(
                    Icons.arrow_right,
                  )
                ],
              ),
            ),
            if (!loading)
              Container(
                // width: 200,
                height: 200,
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: slid.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(
                          left: kDefaultPadding - 5,
                          // right: kDefaultPadding,
                          bottom: 5),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EventDetail(
                                  data: slid[index],
                                ),
                              ));
                        },
                        child: Container(
                          width: 170,
                          height: 200,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 2.0,
                                  color: Colors.black.withOpacity(0.1)),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    slid[index]['img'],
                                    width: double.infinity,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  slid[index]['eventName'],
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge
                                      ?.copyWith(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    Image.asset(
                                      'assets/users.png',
                                      width: 50,
                                      height: 25,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      '+20 Going',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall
                                          ?.copyWith(color: Color(0xFF3F38DD)),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            if (loading)
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Center(
                  child: LoadingAnimationWidget.discreteCircle(
                    size: 40,
                    color: Colors.amber,
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.only(
                  left: kDefaultPadding,
                  right: kDefaultPadding,
                  top: kDefaultPadding,
                  bottom: 10),
              child: Row(
                children: [
                  Text(
                    'Past Events',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  Text(
                    'See All',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: Colors.black.withOpacity(0.5),
                        fontWeight: FontWeight.bold),
                  ),
                  Icon(
                    Icons.arrow_right,
                  )
                ],
              ),
            ),
            if (!loading)
              Container(
                // width: 200,
                height: 200,
                // color: Colors.amber,
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: slid1.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(
                          left: kDefaultPadding - 5,
                          // right: kDefaultPadding,
                          bottom: 5),
                      child: Container(
                        width: 170,
                        height: 200,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 2.0,
                                color: Colors.black.withOpacity(0.1)),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  slid1[index]['img'],
                                  width: double.infinity,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                slid1[index]['eventName'],
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge
                                    ?.copyWith(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Image.asset(
                                    'assets/users.png',
                                    width: 50,
                                    height: 25,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    '+20 Going',
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelSmall
                                        ?.copyWith(color: Color(0xFF3F38DD)),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            if (loading)
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Center(
                  child: LoadingAnimationWidget.discreteCircle(
                    size: 40,
                    color: Colors.amber,
                  ),
                ),
              ),

            Padding(
              padding: const EdgeInsets.only(
                  left: kDefaultPadding,
                  right: kDefaultPadding - 10,
                  top: kDefaultPadding,
                  bottom: 10),
              child: Image.asset(
                'assets/invite.png',
                width: MediaQuery.of(context).size.width,
                // height: 200,
                // fit: BoxFit.cover,
              ),
            )

            // FutureBuilder(
            //   builder: (ctx, snapshot) {
            //     // Checking if future is resolved or not
            //     if (snapshot.connectionState == ConnectionState.done) {
            //       // If we got an error
            //       if (snapshot.hasError) {
            //         return Center(
            //           child: Text(
            //             '${snapshot.error} occurred',
            //             style: TextStyle(fontSize: 18),
            //           ),
            //         );

            //         // if we got our data
            //       } else if (snapshot.hasData) {
            //         // Extracting data from snapshot object
            //         final data = snapshot.data!['data'] as List<dynamic>;
            //         return Container(
            //           // width: 200,
            //           height: 200,
            //           child: ListView.builder(
            //             physics: BouncingScrollPhysics(),
            //             scrollDirection: Axis.horizontal,
            //             shrinkWrap: true,
            //             itemCount: data.length,
            //             itemBuilder: (context, index) {
            //               return Padding(
            //                 padding: const EdgeInsets.only(
            //                     left: kDefaultPadding - 5,
            //                     // right: kDefaultPadding,
            //                     bottom: 5),
            //                 child: Container(
            //                   width: 170,
            //                   height: 200,
            //                   decoration: BoxDecoration(
            //                     color: Colors.white,
            //                     borderRadius: BorderRadius.circular(10),
            //                     boxShadow: [
            //                       BoxShadow(
            //                           blurRadius: 2.0,
            //                           color: Colors.black.withOpacity(0.1)),
            //                     ],
            //                   ),
            //                   child: Padding(
            //                     padding: const EdgeInsets.all(8.0),
            //                     child: Column(
            //                       crossAxisAlignment: CrossAxisAlignment.start,
            //                       children: [
            //                         ClipRRect(
            //                           borderRadius: BorderRadius.circular(10),
            //                           child: Image.network(
            //                             data[index]['img'],
            //                             width: double.infinity,
            //                             height: 100,
            //                             fit: BoxFit.cover,
            //                           ),
            //                         ),
            //                         SizedBox(
            //                           height: 10,
            //                         ),
            //                         Text(
            //                           data[index]['eventName'],
            //                           style: Theme.of(context)
            //                               .textTheme
            //                               .labelSmall
            //                               ?.copyWith(color: Colors.black),
            //                         ),
            //                         Row(
            //                           children: [
            //                             Image.asset(
            //                               'assets/users.png',
            //                               width: 50,
            //                               height: 25,
            //                             ),
            //                             SizedBox(
            //                               width: 5,
            //                             ),
            //                             Text(
            //                               '+20 Going',
            //                               style: Theme.of(context)
            //                                   .textTheme
            //                                   .labelSmall
            //                                   ?.copyWith(
            //                                       color: Color(0xFF3F38DD)),
            //                             ),
            //                           ],
            //                         )
            //                       ],
            //                     ),
            //                   ),
            //                 ),
            //               );
            //             },
            //           ),
            //         );
            //       }
            //     }

            //     // Displaying LoadingSpinner to indicate waiting state
            //     return Padding(
            //       padding: const EdgeInsets.only(top: 20),
            //       child: Center(
            //         child: LoadingAnimationWidget.discreteCircle(
            //           size: 40,
            //           color: Colors.amber,
            //         ),
            //       ),
            //     );
            //   },
            //   future: fetchData(),
            // ),
          ],
        ),
      ),
    ));
  }
}
