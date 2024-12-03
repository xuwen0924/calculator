import 'package:calculator/notepad/bindings.dart';
import 'package:calculator/notepad/view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'names.dart';
import 'observers.dart';

class AppPages {
  static const INITIAL = AppRoutes.initial;
  static final RouteObserver<Route> observer = RouteObservers();
  static List<String> history = [];

  static final List<GetPage> routes = [
    GetPage(
      name: AppRoutes.initial,
      page: () => NotePadPage(),
      binding: NotePadBinding(),
    ),
  ];
}
