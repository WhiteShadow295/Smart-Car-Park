import 'package:flutter/material.dart';
import 'package:smart_car_park/view/homepage.dart';
import 'package:smart_car_park/view/login.dart';
import 'package:smart_car_park/view/parking.dart';
import 'package:smart_car_park/view/analytics.dart';
import 'package:smart_car_park/view/signup.dart';
import 'package:smart_car_park/view/history.dart';

// routes.dart
const String loading = '/';
const String loginRoute = '/login';
const String signupRoute = '/singup';
const String homeRoute = '/home';
const String parkingRoute = '/parking';
const String analyticsRoute = '/analytics';
const String historyRoute = '/history';

final Map<String, WidgetBuilder> routes = {
  loginRoute: (context) => LoginPage(),
  signupRoute: (context) => SignupPage(),
  homeRoute: (context) => const HomePage(),
  parkingRoute: (context) => const ParkingPage(),
  analyticsRoute: (context) => const AnalyticsPage(),
  historyRoute: (context) => const HistoryPage(),
};
