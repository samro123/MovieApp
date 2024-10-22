import 'dart:async';
import 'dart:math';

import 'package:movie_video/app/functions.dart';
import 'package:movie_video/domain/usecase/forgot_password_usecase.dart';
import 'package:movie_video/presentation/base/baseviewmodel.dart';
import 'package:movie_video/presentation/common/state_renderer/state_renderer.dart';
import 'package:movie_video/presentation/common/state_renderer/state_renderer_impl.dart';

class ForgotPasswordViewModel extends BaseViewModel 
    implements ForgotPasswordInput, ForgotPasswordOutput{
  final StreamController _emailStreamController =
      StreamController<void>.broadcast();
  final StreamController _isAllInputValidStreamController =
      StreamController<void>.broadcast();
  final ForgotPasswordUseCase _forgotPasswordUseCase;
  ForgotPasswordViewModel(this._forgotPasswordUseCase);
  var email = "";
  @override
  void start() {
    inputState.add(ContentState());
  }

  @override
  forgotPassword() async{
    inputState.add(
      LoadingState(stateRendererType: StateRendererType.POPUP_LOADING_STATE));
    (await _forgotPasswordUseCase.execute(email)).fold(
            (failure){
              inputState.add(ErrorState(
                  StateRendererType.POPUP_ERROR_STATE, failure.message));
            },
            (supportMessage){
              inputState.add(SuccessState(supportMessage));
            });

  }
  @override
  setEmail(String email) {
    inputEmail.add(email);
    this.email = email;
    _validate();
  }
  @override
  void dispose() {
    _emailStreamController.close();
    _isAllInputValidStreamController.close();
  }

  @override
  // TODO: implement inputEmail
  Sink get inputEmail => _emailStreamController.sink;

  @override
  // TODO: implement inputIsAllInputValid
  Sink get inputIsAllInputValid => _isAllInputValidStreamController.sink;

  @override
  // TODO: implement outputIsAllInputValid
  Stream<bool> get outputIsAllInputValid =>
      _isAllInputValidStreamController.stream
          .map((isAllInputValid) => _isAllInputValid());

  @override
  // TODO: implement outputIsEmailValid
  Stream<bool> get outputIsEmailValid =>
      _emailStreamController.stream.map((email) => isEmailValid(email));
  _isAllInputValid(){
    return isEmailValid(email);
  }
  _validate(){
    inputIsAllInputValid.add(null);
  }


}

abstract class ForgotPasswordInput{
  forgotPassword();
  setEmail(String email);
  Sink get inputEmail;
  Sink get inputIsAllInputValid;
}
abstract class ForgotPasswordOutput{
  Stream<bool> get outputIsEmailValid;
  Stream<bool> get outputIsAllInputValid;
}