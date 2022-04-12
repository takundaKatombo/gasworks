import 'package:flutter/material.dart';
import 'package:gasworks/locator.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:gasworks/constants/route_names.dart' as routes;
import 'package:gasworks/services/router.dart' as router;

void main() {
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gas Works',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      navigatorKey: StackedService.navigatorKey,
      onGenerateRoute: router.generateRoute,
      initialRoute: routes.HomeRoute,
    );
  }
}
