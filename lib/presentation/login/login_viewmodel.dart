import 'dart:async';

import 'package:movie_video/domain/usecase/login_usecase.dart';
import 'package:movie_video/presentation/base/baseviewmodel.dart';
import 'package:movie_video/presentation/common/freezed_data_classes.dart';
import 'package:movie_video/presentation/common/state_renderer/state_renderer.dart';
import 'package:movie_video/presentation/common/state_renderer/state_renderer_impl.dart';

class LoginViewModel extends BaseViewModel implements 
    LoginViewModelInputs, LoginViewModelOutputs{
  StreamController<String> _usernameStreamController=
      StreamController<String>.broadcast();
  StreamController<String> _passwordStreamController=
      StreamController<String>.broadcast();
  StreamController _isAllInputsValidStreamController=
      StreamController<void>.broadcast();
  StreamController isUserLoggedInSuccessfullyStreamController=
      StreamController<String>();
  var loginObject = LoginObject("", "");
  LoginUseCase _loginUseCase;
  LoginViewModel(this._loginUseCase);

  @override
  void dispose() {
    _usernameStreamController.close();
    _passwordStreamController.close();
    _isAllInputsValidStreamController.close();
    isUserLoggedInSuccessfullyStreamController.close();
  }

  @override
  void start() {
    inputState.add(ContentState());
  }

  @override
  // TODO: implement inputPassword
  Sink get inputPassword => _passwordStreamController.sink;

  @override
  // TODO: implement inputUserName
  Sink get inputUserName => _usernameStreamController.sink;

  @override
  // TODO: implement inputIsAllInputValid
  Sink get inputIsAllInputValid => _isAllInputsValidStreamController.sink;

  @override
  login() async{
    inputState.add(LoadingState(stateRendererType: StateRendererType.POPUP_LOADING_STATE));
    (await _loginUseCase.execute(
        LoginUseCaseInput(loginObject.username, loginObject.password)))
        .fold((failure) => {
          inputState.add(ErrorState(
          StateRendererType.POPUP_ERROR_STATE, failure.message))},
            (data){
          inputState.add(ContentState());
          isUserLoggedInSuccessfullyStreamController.add(data.token);
            });
  }
  @override
  setPassword(String password) {
    inputPassword.add(password);
    loginObject = loginObject.copyWith(
      password: password);
    _validate();
  }

  @override
  setUserName(String username) {
    inputUserName.add(username);
    loginObject = loginObject.copyWith(
      username: username);
    _validate();
  }

  @override
  // TODO: implement outputIsPasswordValid
  Stream<bool> get outputIsPasswordValid =>
      _passwordStreamController.stream
        .map((password) => _isPasswordValid(password));

  @override
  // TODO: implement outputIsUserNameValid
  Stream<bool> get outputIsUserNameValid =>
      _usernameStreamController.stream
        .map((username) => _isUsernameValid(username));

  @override
  // TODO: implement outputIsAllInputsValid
  Stream<bool> get outputIsAllInputsValid =>
      _isAllInputsValidStreamController.stream.map((_) => _isAllInputsValid());

  _validate() {
    inputIsAllInputValid.add(null);
  }
  bool _isPasswordValid(String password){
    return password.isNotEmpty;
  }
  bool _isUsernameValid(String username){
    return username.isNotEmpty;
  }
  bool _isAllInputsValid(){
    return _isPasswordValid(loginObject.password) && 
           _isUsernameValid(loginObject.username);
  }
}



abstract class LoginViewModelInputs{
  setUserName(String username);
  setPassword(String password);
  login();
  Sink get inputUserName;
  Sink get inputPassword;
  Sink get inputIsAllInputValid;
}

abstract class LoginViewModelOutputs{
  Stream<bool> get outputIsUserNameValid;
  Stream<bool> get outputIsPasswordValid;
  Stream<bool> get outputIsAllInputsValid;
}