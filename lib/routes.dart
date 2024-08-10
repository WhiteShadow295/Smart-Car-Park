import 'package:flutter/material.dart';
import 'package:smart_car_park/view/homepage.dart';
import 'package:smart_car_park/view/login.dart';
import 'package:smart_car_park/view/parking.dart';
import 'package:smart_car_park/view/car_info.dart';

// routes.dart
const String loading = '/';
const String loginRoute = '/login';
const String homeRoute = '/home';
const String parkingRoute = '/parking';
const String carInfoRoute = '/car_info';

final Map<String, WidgetBuilder> routes = {
  loginRoute: (context) => const LoginPage(),
  homeRoute: (context) => const HomePage(),
  parkingRoute: (context) => ParkingPage(),
  carInfoRoute: (context) => const CarInfoPage()
};
