import 'package:flutter/material.dart';
import 'package:movie_video/presentation/resources/route_manager.dart';
import 'package:movie_video/presentation/resources/theme_manager.dart';
class MyApp extends StatefulWidget {
   MyApp._instance();
   static final MyApp instance = MyApp._instance();
   int appState = 0;
   factory MyApp() => instance;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteGenerator.getRoute,
      initialRoute: Routes.splashRoute,
      theme: getApplicationTheme(),
    );
  }
}
