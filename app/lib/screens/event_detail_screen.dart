import 'package:flutter/material.dart';
import 'package:flutter_hackathon/constants.dart';
import 'package:flutter_hackathon/constants/colors.dart';
import 'package:flutter_hackathon/services/get_events.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:lottie/lottie.dart';

class EventDetail extends StatefulWidget {
  const EventDetail({
    super.key,
    this.data,
    this.isVolunteer,
  });
  final Map<dynamic, dynamic>? data;
  final bool? isVolunteer;

  @override
  State<EventDetail> createState() => _EventDetailState();
}

class _EventDetailState extends State<EventDetail> {
  bool showBooked = false;
  bool isParticipant = true;
  bool? valueId = false;
  late DateTime date = DateFormat('yyyy-MM-dd').parse(widget.data!["date"]);
  Future<void> _dialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Event Booked Successfully'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Lottie.asset('assets/animation.json', repeat: false),
            ],
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Close'),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          EventDetail(data: widget.data, isVolunteer: false),
                    ));
                // Navigator.pop(context);
                // Navigator.pushNamedAndRemoveUntil(
                //   context,
                //   SocialHomeScreen.routeName,
                //   (route) => false,
                // );
              },
            ),
          ],
        );
      },
    );
  }

  // late ApiService _apiService;

  // hitApi(String id) async {
  //   _apiService.join(id, isParticipant);
  // }

  @override
  Widget build(BuildContext context) {
    // initState() {
    //   _apiService = ApiService();
    // }

    // final args = ModalRoute.of(context)!.settings.arguments as EventDetailArg;
    // final data = args.data;
    return SafeArea(
        child: Scaffold(
            // backgroundColor: MyColors.offWhite,
            body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          topBar(context),

          Padding(
            padding: const EdgeInsets.only(
              left: kDefaultPadding,
            ),
            child: Text(
              widget.data!['eventName'],
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset('assets/date.png', height: 60),
                SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${DateFormat('dd MMMM yyyy').format(date).toString()}",
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Text(widget.data!['time'])
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset('assets/location.png', height: 60),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.data!['location'],
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        'Opposite rasiya sultan',
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            color: Colors.black.withOpacity(0.3),
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset('assets/organizer.png', height: 60),
                SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Organizer',
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 14),
                        ),
                        // Spacer(),
                        // Image.asset(
                        //   'assets/foloow.png',
                        //   width: 70,
                        //   height: 50,
                        // )
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Text(
                  'About Event',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),

          Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 22),
            child: Text(
              widget.data!['prMessage'],
              maxLines: 10,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          // Container(
          //   width: double.infinity,
          //   margin: const EdgeInsets.symmetric(horizontal: 20),
          //   child: Image.asset(
          //     'assets/icons/location.png',
          //   ),
          // ),
          Row(
            children: [
              Checkbox(
                value: widget.isVolunteer ?? valueId,
                onChanged: (bool? value) {
                  setState(() {
                    valueId = value!;
                  });
                },
              ),
              Text(
                'Do you want to participate as a volunteer',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: Color(0xFF3F38DD)),
              ),
            ],
          ),
          showBooking(showBooked),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      // hitApi(data.id ?? '');
                      await EventsService().createEvent(widget.data!['_id'],
                          widget.isVolunteer! ? 'Volunteer' : 'participant');
                      setState(() {
                        showBooked = true;
                      });
                      _dialogBuilder(context);
                    },
                    child: Text(
                      'Buy Ticket',
                      textAlign: TextAlign.center,
                    ),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: MyColors.primaryColor,
                        foregroundColor: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          )
        ],
      ),
    )));
  }

  Widget showBooking(bool b) {
    if (!b) return Container();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        'You will receive a email with a link to process your payment and registration',
        style: TextStyle(color: Colors.green, fontSize: 14),
      ),
    );
  }

  Container topBar(BuildContext context) {
    return Container(
      height: 245,
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 160,
            decoration: BoxDecoration(
                image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(
                widget.data!['img'],
              ),
            )),
          ),
          // back btn
          Positioned(
              top: 15,
              left: 5,
              child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ))),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 18.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Events Details',
                    style: TextStyle(color: Colors.white, fontSize: 20))
              ],
            ),
          ),
          Positioned(
              top: 115,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: 70,
                    margin: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.1),
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                'assets/users.png',
                                height: 40,
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Text('+20 going!!',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 18)),
                              SizedBox(
                                width: 10,
                              ),
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xFF4A43EC),
                                    elevation: 0,
                                  ),
                                  onPressed: () {},
                                  child: Text('Invite'))
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
