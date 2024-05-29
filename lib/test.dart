import 'package:flutter/material.dart';
import 'package:movie_video/app/app.dart';
class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);
  void updateAppState(){
    MyApp.instance.appState = 0;
  }
  void getAppState(){
    print(MyApp.instance.appState);
  }

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
