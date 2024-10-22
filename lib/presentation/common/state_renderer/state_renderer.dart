import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:movie_video/app/extensions.dart';
import 'package:movie_video/data/network/failure.dart';
import 'package:movie_video/presentation/resources/assets_manager.dart';
import 'package:movie_video/presentation/resources/color_manager.dart';
import 'package:movie_video/presentation/resources/font_manager.dart';
import 'package:movie_video/presentation/resources/strings_manager.dart';
import 'package:movie_video/presentation/resources/style_manager.dart';
import 'package:movie_video/presentation/resources/value_manager.dart';

enum StateRendererType{
  POPUP_LOADING_STATE,
  POPUP_ERROR_STATE,
  POPUP_SUCCESS,
  FULL_SCREEN_LOADING_STATE,
  FULL_SCREEN_ERROR_STATE,
  CONTENT_SCREEN_STATE,
  EMPTY_SCREEN_STATE
}
class StateRenderer extends StatelessWidget{
  StateRendererType stateRendererType;
  String message;
  String title;
  Function retryActionFunction;
  StateRenderer(
  {Key? key,
  required this.stateRendererType,
    Failure? failure,
    String? message,
    String? title,
    required this.retryActionFunction
  }):
      message = message ?? AppString.loading,
      title = title ?? EMPTY,
      super(key: key);

  @override
  Widget build(BuildContext context) {
    return _getStateWidget(context);
  }

  Widget _getStateWidget(BuildContext context){
    switch(stateRendererType){
      case StateRendererType.POPUP_LOADING_STATE:
        return _getPopUpDialog(context, [_getAnimatedImage(JsonAssets.loading)]);
      case StateRendererType.POPUP_ERROR_STATE:
        return _getPopUpDialog(context, [
          _getAnimatedImage(JsonAssets.error),
          _getMessage(message),
          _getRetryButton(AppString.ok, context)
        ]);
      case StateRendererType.FULL_SCREEN_LOADING_STATE:
        return _getItemInColumn([
          _getAnimatedImage(JsonAssets.loading),
          _getMessage(message)]);
      case StateRendererType.POPUP_SUCCESS:
        return _getPopUpDialog(
            context,
            [
              _getAnimatedImage(JsonAssets.success),
              _getMessage(title),
              _getMessage(message),
              _getRetryButton(AppString.ok, context)
            ]);
      case StateRendererType.FULL_SCREEN_ERROR_STATE:
        return _getItemInColumn([
          _getAnimatedImage(JsonAssets.error),
          _getMessage(message),
          _getRetryButton(AppString.retry_again, context)
        ]);
      case StateRendererType.CONTENT_SCREEN_STATE:
        return Container();
      case StateRendererType.EMPTY_SCREEN_STATE:
        return _getItemInColumn([
          _getAnimatedImage(JsonAssets.empty),
          _getMessage(message)
        ]);
      default:
       return Container();
    }
  }

  Widget _getPopUpDialog(BuildContext context, List<Widget> children){
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSize.s14)
      ),
      elevation: AppSize.s1_5,
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: ColorManager.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(AppSize.s14),
          boxShadow: [BoxShadow(
            color: Colors.black26,
            blurRadius: AppSize.s12,
            offset: Offset(AppSize.s0, AppSize.s12)
          )]
        ),
        child: _getDialogContent(context, children),
      ),
    );
  }

  Widget _getDialogContent(BuildContext context, List<Widget> children){
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    );
  }

  Widget _getAnimatedImage(String animationName){
    return SizedBox(
      height: AppSize.s100,
      width: AppSize.s100,
      child: Lottie.asset(animationName),
    );
  }

  Widget _getMessage(String message){
    return Padding(
        padding: const EdgeInsets.all(AppPadding.p18),
        child: Text(message, style: getMediumStyle(color: ColorManager.black, fontSize: FontSize.s16),),
    );
  }

  Widget _getRetryButton(String buttonTitle, BuildContext context){
    return Padding(
        padding: const EdgeInsets.all(AppPadding.p18),
        child: SizedBox(
          width: AppSize.s180,
          child: ElevatedButton(
            onPressed: (){
              if(stateRendererType == StateRendererType.FULL_SCREEN_ERROR_STATE){
                retryActionFunction?.call();
              }else{
                Navigator.of(context).pop();
              }
            },
            child: Text(buttonTitle),
          ),
        ),
    );
  }

  Widget _getItemInColumn(List<Widget> children){
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: children,
      ),
    );
  }
}