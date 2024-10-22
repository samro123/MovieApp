// on_boarding_viewmodel.dart
import 'dart:async';

import 'package:movie_video/domain/model/model.dart';
import 'package:movie_video/presentation/base/baseviewmodel.dart';
import 'package:movie_video/presentation/resources/assets_manager.dart';
import 'package:movie_video/presentation/resources/strings_manager.dart';

class OnBoardingViewModel extends BaseViewModel
    implements OnBoardingViewModelInputs, OnBoardingViewModelOutputs {

  final StreamController<SliderViewObject> _streamController = StreamController<SliderViewObject>.broadcast();
  final StreamController<void> _navigationController = StreamController<void>.broadcast();

  late final List<SliderObject> _list;
  int currentIndex = 0;
  Timer? _timer;

  @override
  void dispose() {
    _streamController.close();
    _navigationController.close();
    _timer?.cancel();
  }

  @override
  void start() {
    _list = _getSliderData();
    _postDataToView();
    startTimer();
  }

  @override
  void goNext() {
    if (currentIndex < _list.length - 1) {
      currentIndex++;
    } else {
      currentIndex = 0; // Infinite loop to first slide
    }
    _postDataToView();
    _navigateToPage();
  }

  @override
  void goPrevious() {
    if (currentIndex > 0) {
      currentIndex--;
    } else {
      currentIndex = _list.length - 1; // Infinite loop to last slide
    }
    _postDataToView();
    _navigateToPage();
  }

  @override
  void onPageChanged(int index) {
    currentIndex = index;
    _postDataToView();
  }

  @override
  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      goNext();
    });
  }

  void _navigateToPage() {
    _navigationController.add(null); // Emit an event to navigate
  }

  @override
  Sink get inputSliderViewObject => _streamController.sink;

  @override
  Stream<SliderViewObject> get outputSliderViewObject =>
      _streamController.stream.map((sliderViewObject) => sliderViewObject);

  Stream<void> get navigateToPageStream => _navigationController.stream;

  // Private functions
  List<SliderObject> _getSliderData() => [
    SliderObject(AppString.onBoardingTitle1, AppString.onBoardingSubTitle1, ImageAssets.onboardingLogo1),
    SliderObject(AppString.onBoardingTitle2, AppString.onBoardingSubTitle2, ImageAssets.onboardingLogo2),
    SliderObject(AppString.onBoardingTitle3, AppString.onBoardingSubTitle3, ImageAssets.onboardingLogo3),
    SliderObject(AppString.onBoardingTitle4, AppString.onBoardingSubTitle4, ImageAssets.onboardingLogo4),
  ];

  void _postDataToView() {
    inputSliderViewObject.add(SliderViewObject(_list, _list.length, currentIndex));
  }
}

abstract class OnBoardingViewModelInputs {
  void goNext();
  void goPrevious();
  void startTimer();
  void onPageChanged(int index);

  Sink get inputSliderViewObject;
}

abstract class OnBoardingViewModelOutputs {
  Stream<SliderViewObject> get outputSliderViewObject;
}

class SliderViewObject {
  final List<SliderObject> sliderList;
  final int numOfSlide;
  final int currentIndex;

  SliderViewObject(this.sliderList, this.numOfSlide, this.currentIndex);
}
