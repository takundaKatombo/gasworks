import 'package:flutter/material.dart';
import 'package:gasworks/constants/route_names.dart';
import 'package:gasworks/views/addAppliance/addappliance_view.dart';
import 'package:gasworks/views/home/home_view.dart';
import 'package:gasworks/views/undefined.dart';

import '../views/addrooms/addrooms_view.dart';
import '../views/createsite/createsite_view.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {

    // case LoginRoute:
    //   return MaterialPageRoute(builder: (context) => Login());
    case HomeRoute:
      return MaterialPageRoute(builder: (context) => HomeView());
    case CreateSitesRoute:
      return MaterialPageRoute(builder: (context) => CreateSite());
    case AddRoomsRoute:
      return MaterialPageRoute(builder: (context) => AddRooms());
    case AddAppliancesRoute:
      return MaterialPageRoute(builder: (context) => AddAppliance());
    // case PipeSizingResultsRoute:
    //   return MaterialPageRoute(builder: (context) => Metrics());
    default:
      return MaterialPageRoute(builder: (context) => Undefined());
  }
}
