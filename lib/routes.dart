import 'package:flutter/material.dart';
import 'package:smart_car_park/view/homepage.dart';
import 'package:smart_car_park/view/login.dart';

// routes.dart
const String loading = '/';
const String loginRoute = '/login';
const String homeRoute = '/home';

final Map<String, WidgetBuilder> routes = {
  loginRoute: (context) => const LoginPage(),
  homeRoute: (context) => const HomePage(),
};
