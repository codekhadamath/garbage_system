import 'package:flutter/material.dart';
import 'package:garbage_system/models/place_model.dart';
import 'package:garbage_system/pages/auth_page.dart';
import 'package:garbage_system/pages/bin_location_page.dart';
import 'package:garbage_system/pages/detail_page.dart';
import 'package:garbage_system/pages/edit_bin_page.dart';
import 'package:garbage_system/pages/home_page/home_page.dart';
import 'package:garbage_system/pages/no_of_bins_page.dart';
import 'package:garbage_system/pages/recycle_page.dart';
import 'package:garbage_system/pages/welcome_page.dart';
import 'package:garbage_system/wrapper.dart';

class RouteGenerator {
  static const authRoute = '/auth_route';
  static const binLocationRoute = '/bin_location_route';
  static const detailRoute = '/detail_route';
  static const editBinRoute = '/edit_bin_route';
  static const homeRoute = '/home_route';
  static const noOfBinsRoute = '/no_of_bins_route';
  static const recycleRoute = '/recycle_route';
  static const welcomeRoute = '/welcome_route';
  static const wrapperRoute = '/wrapper_route';

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case authRoute:
        return MaterialPageRoute(builder: (context) => const AuthPage());
      case binLocationRoute:
        return MaterialPageRoute(builder: (context) => const BinLocationPage());
      case detailRoute:
        if (args.runtimeType == Place) {
          return MaterialPageRoute(
              builder: (context) => DetailPage(
                    place: args as Place,
                  ));
        }
        return _errorRoute;
      case editBinRoute:
        return MaterialPageRoute(
              builder: (context) => EditBinPage(
                    place: args != null ? args as Place : null,
                  ));
      case homeRoute:
        return MaterialPageRoute(builder: (context) => const Home());
      case noOfBinsRoute:
        return MaterialPageRoute(builder: (context) => const NoOfBinsPage());
      case recycleRoute:
        return MaterialPageRoute(builder: (context) => const RecyclePage());
      case welcomeRoute:
        return MaterialPageRoute(builder: (context) => const Welcome());
      case wrapperRoute:
        return MaterialPageRoute(builder: (context) => const Wrapper());
    }
    return null;
  }

  static get _errorRoute => const Scaffold(
        body: Center(child: Text('Error')),
      );
}
