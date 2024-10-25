import 'dart:async';

import 'package:flutter/material.dart';
import 'package:movie_video/app/app_prefs.dart';
import 'package:movie_video/app/di.dart';
import 'package:movie_video/presentation/resources/assets_manager.dart';
import 'package:movie_video/presentation/resources/color_manager.dart';
import 'package:movie_video/presentation/resources/route_manager.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  AppPreferences _appPreferences = instance<AppPreferences>();
  Timer? _timer;

  _startDelay(){
    _timer = Timer(Duration(seconds: 2), _goNext);
  }

  _goNext()async{
    _appPreferences.isUserLoggedIn().then((isUserLoggedIn) => {
      if(isUserLoggedIn){
        Navigator.pushReplacementNamed(context, Routes.loginRoute)
      }else{
        _appPreferences.isOnBoardingScreenViewed().then((isOnBoardingScreenViewed){
          if(isOnBoardingScreenViewed){
            Navigator.pushReplacementNamed(context, Routes.loginRoute);
          }else{
            Navigator.pushReplacementNamed(context, Routes.onBoardingRoute);
          }
        })
      }
    });


  }

  @override
  void initState() {
    _startDelay();
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primary,
      body: Center(child: Image(image: AssetImage(ImageAssets.splashLogo),),),
    );
  }
}
