import 'package:flutter/material.dart';
import 'package:movie_video/presentation/common/state_renderer/state_renderer.dart';
import 'package:movie_video/presentation/resources/strings_manager.dart';

const EMPTY = "";
const ZERO = 0;
abstract class FlowState{
  StateRendererType getStateRendererType();
  String getMessage();
}
class LoadingState extends FlowState{
  StateRendererType stateRendererType;
  String message;
  LoadingState({required this.stateRendererType, String? message}):
      message = message ?? AppString.loading;

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() => stateRendererType;
}

class ErrorState extends FlowState{
  StateRendererType stateRendererType;
  String message;
  ErrorState(this.stateRendererType, this.message);
  @override
  String getMessage() => message;
  @override
  StateRendererType getStateRendererType()=>stateRendererType;
}

class ContentState extends FlowState{
  ContentState();
  @override
  String getMessage() => EMPTY;
  @override
  StateRendererType getStateRendererType() => StateRendererType.CONTENT_SCREEN_STATE;
}

class EmptyState extends FlowState{
  String message;
  EmptyState(this.message);
  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() => StateRendererType.EMPTY_SCREEN_STATE;
}

class SuccessState extends FlowState{
  String message;
  SuccessState(this.message);

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() => StateRendererType.POPUP_SUCCESS;
}

extension FlowStateExtension on FlowState{
  Widget getScreenWidget(BuildContext context,
      Widget contentScreenWidget,
      Function retryActionFunction){
      switch(this.runtimeType){
        case LoadingState:{
          if(getStateRendererType() ==  StateRendererType.POPUP_LOADING_STATE){
              showPopUp(context, getStateRendererType(), getMessage());
              return contentScreenWidget;
          }else{
            return StateRenderer(
                stateRendererType: getStateRendererType(),
                message: getMessage(),
                retryActionFunction: retryActionFunction);
          }
        }
        case ErrorState:{
          if(getStateRendererType() == StateRendererType.POPUP_ERROR_STATE){
            showPopUp(context, getStateRendererType(), getMessage());
            return contentScreenWidget;
          }else{
            return StateRenderer(
                stateRendererType: getStateRendererType(),
                message: getMessage(),
                retryActionFunction: retryActionFunction);
          }
        }
        case ContentState:{
            dismissDialog(context);
            return contentScreenWidget;
        }
        case EmptyState:{
          return StateRenderer(
              stateRendererType: getStateRendererType(),
              message: getMessage(),
              retryActionFunction: retryActionFunction);
        }
        case SuccessState:{
          dismissDialog(context);
          showPopUp(context, StateRendererType.POPUP_SUCCESS, getMessage(), title: AppString.success);
          return contentScreenWidget;
        }
        default:
          return contentScreenWidget;
      }
  }

  dismissDialog(BuildContext context){
    if(_isThereCurrentDialogShowing(context)){
      Navigator.of(context, rootNavigator: true).pop(true);
    }
  }

  _isThereCurrentDialogShowing(BuildContext context) =>
      ModalRoute.of(context)?.isCurrent != true;

  showPopUp(BuildContext context, StateRendererType stateRendererType,
             String message, {String title = EMPTY }){
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      showDialog(
          context: context,
          builder: (BuildContext context) => StateRenderer(
              stateRendererType: stateRendererType,
              message: message,
              title: title,
              retryActionFunction: (){}));
    });
  }

}