import 'package:flutter/material.dart';
import 'package:movie_video/app/app.dart';
import 'package:movie_video/app/di.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await initAppModule();
  runApp(MyApp());
}

