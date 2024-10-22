// on_boarding.dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movie_video/app/app_prefs.dart';
import 'package:movie_video/app/di.dart';
import 'package:movie_video/domain/model/model.dart';
import 'package:movie_video/presentation/onboarding/on_boarding_viewmodel.dart';
import 'package:movie_video/presentation/resources/assets_manager.dart';
import 'package:movie_video/presentation/resources/color_manager.dart';
import 'package:movie_video/presentation/resources/route_manager.dart';
import 'package:movie_video/presentation/resources/strings_manager.dart';
import 'package:movie_video/presentation/resources/value_manager.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({Key? key}) : super(key: key);

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  final PageController _pageController = PageController(initialPage: 0);
  final OnBoardingViewModel _viewModel = OnBoardingViewModel();
  StreamSubscription<void>? _navigationSubscription;
  AppPreferences _appPreferences = instance<AppPreferences>();

  @override
  void initState() {
    super.initState();
    _bind();
  }

  void _bind(){
    _viewModel.start();
    _appPreferences.setOnBoardingScreenViewed();
    _viewModel.outputSliderViewObject.listen((sliderViewObject) {
      setState(() {}); // Update the UI with new data
    });

    // Listen to navigation events to change pages
    _navigationSubscription = _viewModel.navigateToPageStream.listen((_) {
      if(_pageController.hasClients){
        _pageController.animateToPage(
          _viewModel.currentIndex,
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _viewModel.dispose();
    _pageController.dispose();
    _navigationSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primary,
      body: StreamBuilder<SliderViewObject>(
        stream: _viewModel.outputSliderViewObject,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var sliderViewObject = snapshot.data!;
            return PageView.builder(
              controller: _pageController,
              itemCount: sliderViewObject.numOfSlide,
              onPageChanged: _viewModel.onPageChanged,
              itemBuilder: (context, index) {
                return OnBoardingPage(sliderViewObject.sliderList[index]);
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      bottomSheet: StreamBuilder<SliderViewObject>(
        stream: _viewModel.outputSliderViewObject,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var sliderViewObject = snapshot.data!;
            return Container(
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
                    // Add layout for indicator and arrows
                    _getBottomSheetWidget(sliderViewObject),
                    Spacer(),
                    _getBottomSheetWidgetButton(),
                  ],
                ),
              ),
            );
          } else {
            return SizedBox.shrink();
          }
        },
      ),
    );
  }

  Widget _getBottomSheetWidget(SliderViewObject sliderViewObject) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Left arrow
        Padding(
          padding: EdgeInsets.all(AppPadding.p14),
          child: GestureDetector(
            child: SizedBox(
              height: AppSize.s20,
              width: AppSize.s20,
              child: SvgPicture.asset(ImageAssets.leftArrowIc),
            ),
            onTap: () {
              _viewModel.goPrevious();
            },
          ),
        ),

        // Circles indicator
        Row(
          children: List.generate(sliderViewObject.numOfSlide, (index) {
            return Padding(
              padding: EdgeInsets.all(AppPadding.p8),
              child: _getProperCircle(index, sliderViewObject.currentIndex),
            );
          }),
        ),

        // Right arrow
        Padding(
          padding: EdgeInsets.all(AppPadding.p14),
          child: GestureDetector(
            child: SizedBox(
              height: AppSize.s20,
              width: AppSize.s20,
              child: SvgPicture.asset(ImageAssets.rightArrowIc),
            ),
            onTap: () {
              _viewModel.goNext();
            },
          ),
        ),
      ],
    );
  }

  Widget _getProperCircle(int index, int currentIndex) {
    if (index == currentIndex) {
      return SvgPicture.asset(ImageAssets.hollowCircleIc); // Selected slider
    } else {
      return SvgPicture.asset(ImageAssets.solidCircleIc); // Unselected slider
    }
  }

  Widget _getBottomSheetWidgetButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p12),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: AppSize.s53,
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
            height: AppSize.s53,
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
  final SliderObject sliderObject;

  OnBoardingPage(this.sliderObject, {Key? key}) : super(key: key);

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
            child: SvgPicture.asset(sliderObject.image)),
        const SizedBox(
          height: AppSize.s40,
        ),
        Padding(
          padding: const EdgeInsets.all(AppPadding.p8),
          child: Text(
            sliderObject.title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline1,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(AppPadding.p8),
          child: Text(
            sliderObject.subTitle,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.subtitle1,
          ),
        ),
      ],
    );
  }
}
