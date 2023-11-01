import 'dart:convert';

// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_hackathon/screens/arvr/ag_explore_screen.dart';
import 'package:flutter_hackathon/screens/arvr/ag_home_screen.dart';
import 'package:flutter_hackathon/screens/arvr/panorama_view.dart';
import 'package:flutter_hackathon/screens/arvr/products_list_screen.dart';
import 'package:flutter_hackathon/screens/home_screen.dart';
import 'package:flutter_hackathon/screens/my_events_screen.dart';
import 'package:flutter_hackathon/screens/profile_screen.dart';
import 'package:flutter_hackathon/screens/web_screen.dart';
import 'package:flutter_hackathon/services/get_events.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constants/colors.dart';

// import '../firebase_notification_provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // current index state
  int _currentIndex = 0;

  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    initMessaging();
    _currentIndex = 0;
    // NotificationListenerProvider().getMessage(context);
    sendPushToken();
  }

  void initMessaging() {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    FlutterLocalNotificationsPlugin fltNotification =
        FlutterLocalNotificationsPlugin();
    var androiInit = const AndroidInitializationSettings('@mipmap/ic_launcher');
    var iosInit = const DarwinInitializationSettings();
    var initSetting = InitializationSettings(android: androiInit);

    fltNotification.initialize(initSetting);
    var androidDetails =
        const AndroidNotificationDetails("default", "channel name");
    var iosDetails = const DarwinNotificationDetails();
    var generalNotificationDetails =
        NotificationDetails(android: androidDetails, iOS: iosDetails);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        fltNotification.show(notification.hashCode, notification.title,
            notification.body, generalNotificationDetails);
      }
    });
  }

  sendPushToken() async {
    final token = await FirebaseMessaging.instance.getToken();
    if (token != null) {
      print('token: ' + token);
      await EventsService().sendFcmToken(token);
    } else
      print('token is null');
  }

  final _advancedDrawerController = AdvancedDrawerController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MyColors.gray3,
        body: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            AGHomeScreen(),
            AGExploreMapScreen(),
            ProductListScreen(),
            ProfileScreen(),
          ],
          onPageChanged: (idx) {
            setState(() {
              _currentIndex = idx;
            });
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (ctx) => PanoramaPage(
                      images: [
                        'https://firebasestorage.googleapis.com/v0/b/apnaghar-ef0ca.appspot.com/o/1.jpg?alt=media&token=50bef1d0-a0db-493c-8900-58335b50b122',
                        'https://firebasestorage.googleapis.com/v0/b/apnaghar-ef0ca.appspot.com/o/2.jpg?alt=media&token=03e5406c-6b10-4d24-a7af-d03484ba6691',
                        'https://firebasestorage.googleapis.com/v0/b/apnaghar-ef0ca.appspot.com/o/3.jpg?alt=media&token=02c63c67-a914-44fa-a3a5-d925450b39a0'
                      ],
                      labels: ['Entrance', 'Point 1', 'Point 2'],
                    )));
          },
          backgroundColor: MyColors.primaryColor,
          child: SvgPicture.asset(
            'assets/images/fab.svg',
            height: 20,
            width: 20,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: MyColors.white,
          unselectedItemColor: MyColors.onPrimaryColor,
          currentIndex: _currentIndex,
          onTap: (int index) {
            setState(() {
              _currentIndex = index;
              _pageController
                  .jumpTo(_currentIndex * MediaQuery.of(context).size.width);
            });
          },
          type: BottomNavigationBarType.fixed,
          selectedItemColor: MyColors.primaryColor,
          items: [
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(bottom: 2.0),
                child: SvgPicture.asset(
                  'assets/home.svg',
                  color: _currentIndex == 0
                      ? MyColors.primaryColor
                      : MyColors.gray2,
                ),
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/images/nav3.svg',
                color:
                    _currentIndex == 1 ? MyColors.primaryColor : MyColors.gray2,
              ),
              label: 'Map',
            ),
            // BottomNavigationBarItem(icon: Icon(Icons.add), label: ""),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/ar.svg',
                height: 24,
                width: 24,
                color:
                    _currentIndex == 2 ? MyColors.primaryColor : MyColors.gray2,
              ),
              label: 'AR',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/images/nav4.svg',
                color:
                    _currentIndex == 3 ? MyColors.primaryColor : MyColors.gray2,
              ),
              label: 'Profile',
            ),
          ],
          // ),
        ));
  }
}
