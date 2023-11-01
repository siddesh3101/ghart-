import 'package:flutter/material.dart';
import 'package:flutter_hackathon/constants.dart';
import 'package:flutter_hackathon/screens/event_detail_screen.dart';
import 'package:flutter_hackathon/services/get_events.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<dynamic> slid = [];
  bool loading = true;
  void fetchData() async {
    try {
      // Replace EventsService().getItinerary() with your data fetching logic here
      final data = await EventsService().getNoti();

      setState(() {
        slid = data;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'Notification',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!loading)
              Container(
                // width: 200,
                height: 130,
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: slid.length,
                  itemBuilder: (context, index) {
                    return Padding(
                        padding: const EdgeInsets.only(
                            left: kDefaultPadding - 5,
                            // right: kDefaultPadding,
                            bottom: 5),
                        child: Container(
                          // height: 100,
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
                                Row(
                                  children: [
                                    Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: NetworkImage(slid[index]
                                                  ['eventId']['img'])),
                                          shape: BoxShape.circle),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Flexible(
                                      child: Column(children: [
                                        Text(
                                          slid[index]['notification'],
                                          style: TextStyle(fontSize: 12),
                                        )
                                      ]),
                                    ),
                                    Text(
                                      'Just Now',
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey.withOpacity(0.8)),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 55,
                                    ),
                                    Image.asset(
                                      'assets/reject.png',
                                      width: 90,
                                      height: 30,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => EventDetail(
                                                  data: slid[index]['eventId'],
                                                  isVolunteer: true),
                                            ));
                                      },
                                      child: Image.asset(
                                        'assets/view.png',
                                        width: 90,
                                        height: 30,
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                        ));
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
