import 'dart:async';

import 'package:movie_video/domain/model.dart';
import 'package:movie_video/presentation/base/baseviewmodel.dart';
import 'package:movie_video/presentation/resources/assets_manager.dart';
import 'package:movie_video/presentation/resources/strings_manager.dart';

class OnBoardingViewModel extends BaseViewModel
    implements OnBoardingViewModelInputs, OnBoardingViewModelOutputs {

  final StreamController _streamController = StreamController();

  late final List<SliderObject> _list;
  int _currentIndex = 0;

  @override
  void dispose() {
    _streamController.close();
  }

  @override
  void start() {
    // TODO: implement start
  }

  @override
  int goNext() {
    int nextIndex = _currentIndex ++; // -1
    if (nextIndex >= _list.length){
      _currentIndex = 0; // infinite loop to go to first item inside the slider
    }
    return _currentIndex;
  }

  @override
  int goPrevious() {
    int previousIndex = _currentIndex --; // -1
    if (previousIndex == -1){
      _currentIndex = _list.length - 1; // infinite loop to go to length  of slider
    }
    return _currentIndex;
  }

  @override
  void onPageChanged(int index) {
    _currentIndex = index;
    _postDataToView();
  }



  @override
  void startTimer() {
    // TODO: implement startTimer
  }

  @override
  // TODO: implement inputSliderViewObject
  Sink get inputSliderViewObject =>_streamController.sink;

  @override
  // TODO: implement outputSliderViewObject
  Stream<SliderViewObject> get outputSliderViewObject  =>
      _streamController.stream.map((slideViewObject) => slideViewObject);

  // private functions
  List<SliderObject> _getSliderData() => [
    SliderObject(AppString.onBoardingTitle1, AppString.onBoardingSubTitle1, ImageAssets.onboardingLogo1),
    SliderObject(AppString.onBoardingTitle2, AppString.onBoardingSubTitle2, ImageAssets.onboardingLogo2),
    SliderObject(AppString.onBoardingTitle3, AppString.onBoardingSubTitle3, ImageAssets.onboardingLogo3),
    SliderObject(AppString.onBoardingTitle4, AppString.onBoardingSubTitle1, ImageAssets.onboardingLogo4),
  ];
  _postDataToView(){
    inputSliderViewObject.add(SliderViewObject(_list[_currentIndex], _list.length, _currentIndex));
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

class SliderViewObject{
  SliderObject sliderObject;
  int numOfSlide;
  int currentIndex;
  SliderViewObject(this.sliderObject,this.numOfSlide, this.currentIndex );
}