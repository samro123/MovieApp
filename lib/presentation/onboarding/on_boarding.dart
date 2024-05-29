import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie_video/domain/model.dart';
import 'package:movie_video/presentation/onboarding/on_boarding_viewmodel.dart';
import 'package:movie_video/presentation/resources/assets_manager.dart';
import 'package:movie_video/presentation/resources/color_manager.dart';
import 'package:movie_video/presentation/resources/route_manager.dart';
import 'package:movie_video/presentation/resources/strings_manager.dart';
import 'package:movie_video/presentation/resources/value_manager.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({Key? key}) : super(key: key);

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  PageController _pageController = PageController(initialPage: 0);
  OnBoardingViewModel _viewModel = OnBoardingViewModel();
  _bind(){
    _viewModel.start();
  }
  Timer? _timer;

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      if (_pageController.page == _list.length - 1) {
        //checks if it's on the last time
        _pageController.animateToPage(0,
            duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
      } else{
        _pageController.nextPage(duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
      }
    });
  }
  @override
  void initState() {
    super.initState();
    _bind();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primary,
      body: PageView.builder(
        controller: _pageController,
        itemCount: _list.length,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        itemBuilder: (context, index) {
          return OnBoardingPage(_list[index]);
        },
      ),
      bottomSheet: Container(
        color: ColorManager.primary,
        height: AppSize.s180,
        child: Padding(
          padding: const EdgeInsets.only(
            left: AppPadding.p12,
            right: AppPadding.p12,
            bottom: AppPadding.p12,
          ),
          child: Column(
            children: [
              //add layout for indicator and arrows
              _getBottomSheetWidget(),
              Spacer(),
              _getBottomSheetWidgetButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getBottomSheetWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //left arrow
        Padding(
          padding: EdgeInsets.all(AppPadding.p14),
          child: GestureDetector(
            child: SizedBox(
              height: AppSize.s20,
              width: AppSize.s20,
              child: SvgPicture.asset(ImageAssets.leftArrowIc),
            ),
            onTap: () {
              // go to next slide
              // go to previous slide
              _pageController.animateToPage(_getPreviousIndex(),
                  duration: Duration(milliseconds: DurationConstant.d300),
                  curve: Curves.bounceInOut);
            },
          ),
        ),

        //circles indicator
        Row(
          children: [
            for (int i = 0; i < _list.length; i++)
              Padding(
                padding: EdgeInsets.all(AppPadding.p8),
                child: _getProperCircle(i),
              )
          ],
        ),

        // right arrow
        Padding(
          padding: EdgeInsets.all(AppPadding.p14),
          child: GestureDetector(
            child: SizedBox(
              height: AppSize.s20,
              width: AppSize.s20,
              child: SvgPicture.asset(ImageAssets.rightArrowIc),
            ),
            onTap: () {
              // go to next slide
              _pageController.animateToPage(_getNextIndex(),
                  duration: Duration(milliseconds: DurationConstant.d300),
                  curve: Curves.bounceInOut);
            },
          ),
        ),
      ],
    );
  }

  int _getPreviousIndex() {
    int previousIndex = _currentIndex--; // -1
    if (previousIndex == -1) {
      _currentIndex =
          _list.length - 1; // infinite loop to go to length  of slider
    }
    return _currentIndex;
  }

  int _getNextIndex() {
    int nextIndex = _currentIndex++; // -1
    if (nextIndex >= _list.length) {
      _currentIndex = 0; // infinite loop to go to first item inside the slider
    }
    return _currentIndex;
  }

  Widget _getProperCircle(int index) {
    if (index == _currentIndex) {
      return SvgPicture.asset(ImageAssets.hollowCircleIc); // selected slider
    } else {
      return SvgPicture.asset(ImageAssets.solidCircleIc); // unselected slider
    }
  }

  Widget _getBottomSheetWidgetButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p12),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: AppSize.s50,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: ColorManager.grey1),
                onPressed: () {
                  Navigator.pushNamed(context, Routes.loginRoute);
                },
                child: Text(
                  AppString.login,
                )),
          ),
          const SizedBox(
            height: AppSize.s12,
          ),
          SizedBox(
            width: double.infinity,
            height: AppSize.s50,
            child: ElevatedButton(
                onPressed: () {},
                child: Text(
                  AppString.register,
                )),
          ),
        ],
      ),
    );
  }
}

class OnBoardingPage extends StatelessWidget {
  SliderObject _sliderObject;

  OnBoardingPage(this._sliderObject, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(
          height: AppSize.s100,
        ),
        Container(
            color: ColorManager.white,
            height: AppSize.s300,
            child: SvgPicture.asset(_sliderObject.image)),
        const SizedBox(
          height: AppSize.s40,
        ),
        Padding(
          padding: const EdgeInsets.all(AppPadding.p8),
          child: Text(
            _sliderObject.title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline1,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(AppPadding.p8),
          child: Text(
            _sliderObject.subTitle,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.subtitle1,
          ),
        ),
      ],
    );
  }
}


