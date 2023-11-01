import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_hackathon/constants/colors.dart';
import 'package:flutter_svg/svg.dart';

import '../services/get_events.dart';

class TabBarPage extends StatefulWidget {
  const TabBarPage({Key? key}) : super(key: key);

  @override
  _TabBarPageState createState() => _TabBarPageState();
}

class _TabBarPageState extends State<TabBarPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Events', style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Container(
                  // height: 50,
                  width: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                      color: MyColors.gray3,
                      borderRadius: BorderRadius.circular(50)),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(5),
                        child: TabBar(
                          unselectedLabelColor: Color(0xFF9B9B9B),
                          labelColor: MyColors.primaryColor,
                          indicatorColor: Colors.white,
                          indicatorWeight: 2,
                          indicator: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          controller: tabController,
                          tabs: [
                            Tab(
                              text: 'UPCOMING',
                            ),
                            Tab(
                              text: 'PAST EVENTS',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: tabController,
                    children: [
                      MyUpcomingEvents(),
                      MyPastEvents(),
                    ],
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

class MyUpcomingEvents extends StatefulWidget {
  const MyUpcomingEvents({super.key});

  @override
  State<MyUpcomingEvents> createState() => _MyUpcomingEventsState();
}

class _MyUpcomingEventsState extends State<MyUpcomingEvents> {
  List<dynamic> events = [];
  bool loading = true;

  void fetchSearchData(String q) async {
    try {
      // Replace EventsService().getItinerary() with your data fetching logic here
      final data = await EventsService().getUserEvents();
      print(data);

      setState(() {
        events = data['data'];
        loading = false;
      });
    } catch (error) {
      throw error;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchSearchData('');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: events.length,
              itemBuilder: (context, index) {
                return SearchItem(
                  date: events[index]['date'] ?? '',
                  title: events[index]['eventName'] ?? '',
                  image: events[index]['img'],
                  chip: events[index]['category'],
                  isVolunteer: events[index]['volunterCheck'] ?? false,
                  onTap: () {
                    // Navigator.pushNamed(context, '/event',
                    //     arguments: events[index]);
                  },
                );
              },
            ),
    );
  }
}

class MyPastEvents extends StatefulWidget {
  const MyPastEvents({super.key});

  @override
  State<MyPastEvents> createState() => _MyPastEventsState();
}

class _MyPastEventsState extends State<MyPastEvents> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
          child: Column(
        children: [
          SizedBox(
            height: 100,
          ),
          SvgPicture.asset('assets/images/no_events.svg',
              height: 200, width: 200),
          SizedBox(
            height: 30,
          ),
          Text(
            'No Past Events',
            style: TextStyle(
                color: MyColors.primaryColor,
                fontSize: 20,
                fontWeight: FontWeight.w600),
          ),
        ],
      )),
    );
  }
}

class SearchItem extends StatelessWidget {
  final String date;
  final String title;
  final String image;
  final Function onTap;
  final String chip;
  final bool isVolunteer;
  const SearchItem(
      {super.key,
      required this.date,
      required this.title,
      required this.image,
      required this.onTap,
      required this.chip,
      required this.isVolunteer});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 3,
              blurRadius: 5,
              offset: const Offset(0, 5), // changes position of shadow
            ),
          ],
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(image, height: 110, width: 110)),
              SizedBox(
                width: 15,
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                            color: MyColors.primaryColor,
                            borderRadius: BorderRadius.circular(10)),
                        child: Text(
                          capitalise(chip),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      if (isVolunteer)
                        Container(
                          padding: EdgeInsets.only(
                              left: 3, top: 3, bottom: 3, right: 8),
                          decoration: BoxDecoration(
                              color: Colors.green[200],
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            children: [
                              Icon(
                                Icons.check_circle,
                                color: Colors.green,
                                size: 15,
                              ),
                              SizedBox(
                                width: 2,
                              ),
                              Text(
                                'Volunteer',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    date,
                    style: TextStyle(
                        color: MyColors.primaryColor,
                        fontSize: 13,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              )),
              SizedBox(
                width: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }

  String capitalise(String s) => s[0].toUpperCase() + s.substring(1);
}
