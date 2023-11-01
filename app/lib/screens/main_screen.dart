import 'dart:convert';

// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
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
            HomeScreen(),
            TabBarPage(),
            WebViewExample(),
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
            Navigator.of(context).pushNamed('/cp');
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
                  'assets/images/nav1.svg',
                  color: _currentIndex == 0
                      ? MyColors.primaryColor
                      : MyColors.gray2,
                ),
              ),
              label: 'Explore',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/images/nav2.svg',
                color:
                    _currentIndex == 1 ? MyColors.primaryColor : MyColors.gray2,
              ),
              label: 'Events',
            ),
            // BottomNavigationBarItem(icon: Icon(Icons.add), label: ""),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/images/nav3.svg',
                color:
                    _currentIndex == 2 ? MyColors.primaryColor : MyColors.gray2,
              ),
              label: 'Map',
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

    return AdvancedDrawer(
      backdrop: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.white, Colors.grey.withOpacity(0.2)],
          ),
        ),
      ),
      controller: _advancedDrawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      animateChildDecoration: true,
      rtlOpening: false,
      // openScale: 1.0,
      disabledGestures: false,
      childDecoration: const BoxDecoration(
        // NOTICE: Uncomment if you want to add shadow behind the page.
        // Keep in mind that it may cause animation jerks.
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black12,
            blurRadius: 0.0,
          ),
        ],
        borderRadius: const BorderRadius.all(Radius.circular(16)),
      ),
      drawer: SafeArea(
        child: Container(
          child: ListTileTheme(
            textColor: Colors.black,
            iconColor: Colors.black,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: 128.0,
                  height: 128.0,
                  margin: const EdgeInsets.only(
                    top: 24.0,
                    bottom: 64.0,
                  ),
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    shape: BoxShape.circle,
                  ),
                  child: SvgPicture.asset(
                    'assets/images/logo.svg',
                    height: 30,
                  ),
                ),
                ListTile(
                  onTap: () {},
                  leading: Icon(Icons.person_outline),
                  title: Text('My Profile'),
                ),
                ListTile(
                  onTap: () {},
                  leading: SvgPicture.asset(
                    'assets/images/nav1.svg',
                    height: 22,
                    width: 22,
                    color: Colors.black,
                  ),
                  title: Text('Explore'),
                ),
                ListTile(
                  onTap: () {},
                  leading: SvgPicture.asset(
                    'assets/images/nav2.svg',
                    height: 22,
                    width: 22,
                    color: Colors.black,
                  ),
                  title: Text('Events'),
                ),
                ListTile(
                  onTap: () {},
                  leading: SvgPicture.asset(
                    'assets/images/nav3.svg',
                    height: 22,
                    width: 22,
                    color: Colors.black,
                  ),
                  title: Text('Map'),
                ),
                ListTile(
                  onTap: () {},
                  leading: Icon(Icons.logout),
                  title: Text('Sign Out'),
                ),
                Spacer(),
                DefaultTextStyle(
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white54,
                  ),
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 16.0,
                    ),
                    child: Text('Terms of Service | Privacy Policy'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      child: Scaffold(
          backgroundColor: MyColors.gray3,
          body: PageView(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              HomeScreen(),
              TabBarPage(),
              WebViewExample(),
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
              Navigator.of(context).pushNamed('/cp');
            },
            backgroundColor: MyColors.primaryColor,
            child: SvgPicture.asset(
              'assets/images/fab.svg',
              height: 20,
              width: 20,
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
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
                    'assets/images/nav1.svg',
                    color: _currentIndex == 0
                        ? MyColors.primaryColor
                        : MyColors.gray2,
                  ),
                ),
                label: 'Explore',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/images/nav2.svg',
                  color: _currentIndex == 1
                      ? MyColors.primaryColor
                      : MyColors.gray2,
                ),
                label: 'Events',
              ),
              // BottomNavigationBarItem(icon: Icon(Icons.add), label: ""),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/images/nav3.svg',
                  color: _currentIndex == 2
                      ? MyColors.primaryColor
                      : MyColors.gray2,
                ),
                label: 'Map',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/images/nav4.svg',
                  color: _currentIndex == 3
                      ? MyColors.primaryColor
                      : MyColors.gray2,
                ),
                label: 'Profile',
              ),
            ],
            // ),
          )),
    );
  }
}
