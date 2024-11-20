import 'package:flutter/material.dart';
import 'package:movie_video/app/di.dart';
import 'package:movie_video/presentation/details_movie/details_movie.dart';
import 'package:movie_video/presentation/forgot_password/forgot_password.dart';
import 'package:movie_video/presentation/login/login.dart';
import 'package:movie_video/presentation/main/main_view.dart';
import 'package:movie_video/presentation/onboarding/on_boarding.dart';
import 'package:movie_video/presentation/register/register.dart';
import 'package:movie_video/presentation/resources/strings_manager.dart';
import 'package:movie_video/presentation/splash/splash.dart';

class Routes {
  static const String splashRoute = '/';
  static const String forgotPasswordRoute = '/forgotPassword';
  static const String loginRoute = '/login';
  static const String registerRoute = '/register';
  static const String mainRoute = '/main';
  static const String onBoardingRoute = '/onBoarding';
  static const String movieDetailsRoute = "/movieDetails";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => SplashView());
      case Routes.onBoardingRoute:
        return MaterialPageRoute(builder: (_) => OnBoardingView());
      case Routes.loginRoute:
        initLoginModule();
        return MaterialPageRoute(builder: (_) => LoginView());
      case Routes.registerRoute:
        initRegisterModule();
        return MaterialPageRoute(builder: (_) => RegisterView());
      case Routes.mainRoute:
        initMainModule();
        return MaterialPageRoute(builder: (_) => MainView());
      case Routes.movieDetailsRoute:
        initCommentModule();
        return MaterialPageRoute(builder: (_) => MovieDetail());
      case Routes.forgotPasswordRoute:
        initForgotPasswordModule();
        return MaterialPageRoute(builder: (_) => ForgotPasswordView());
      default:
        return unDefineRoute();
    }
  }

  static Route<dynamic> unDefineRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              appBar: AppBar(
                title: Text(AppString.noRouteFound),
              ),
              body: Center(
                child: Text(AppString.noRouteFound),
              ),
            ));
  }
}
