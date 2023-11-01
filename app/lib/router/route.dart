import 'package:flutter/material.dart';
import 'package:flutter_hackathon/screens/arvr/products_list_screen.dart';
import 'package:flutter_hackathon/screens/event_detail_screen.dart';
import 'package:flutter_hackathon/screens/event_ticket_screen.dart';
import 'package:flutter_hackathon/screens/login_screen.dart';
import 'package:flutter_hackathon/screens/notification_screen.dart';
import 'package:flutter_hackathon/screens/onboarding_screen.dart';
import 'package:flutter_hackathon/screens/search_petition.dart';
import 'package:flutter_hackathon/screens/profile_screen.dart';
import 'package:flutter_hackathon/screens/search_screen.dart';
import 'package:flutter_hackathon/screens/splash_screen.dart';

import '../screens/create_petitiion.dart';
import '../screens/main_screen.dart';

Map<String, Widget Function(BuildContext)> routes = {
  '/': (context) => Splash(),
  '/search': (context) => SearchScreen(),
  '/detail': (context) => EventDetail(),
  '/searchPet': (p0) => SearchPetition(),
  '/ticket': (context) => EventTicketScreen(),
  '/profile': (context) => ProfileScreen(),
  '/notification': (context) => NotificationScreen(),
  '/cp': (p0) => CreatePetition(),
  '/arfurniture': (p0) => ProductListScreen(),
  '/home': (p0) => MainPage(),

  // '/ob': (context) => OnboaardingScreen()
};

String initRoute = '/home';
