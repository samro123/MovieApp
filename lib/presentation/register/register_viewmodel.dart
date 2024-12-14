import 'dart:async';

import 'package:movie_video/domain/usecase/register_usecase.dart';
import 'package:movie_video/presentation/base/baseviewmodel.dart';
import 'package:movie_video/presentation/common/freezed_data_classes.dart';
import 'package:movie_video/presentation/common/state_renderer/state_renderer.dart';
import 'package:movie_video/presentation/common/state_renderer/state_renderer_impl.dart';

class RegisterViewModel extends BaseViewModel
    implements RegisterViewModelInput, RegisterViewModelOutput{
  StreamController _usernameStreamController = StreamController<String>.broadcast();
  StreamController _passwordStreamController = StreamController<String>.broadcast();
  StreamController _firstNameStreamController = StreamController<String>.broadcast();
  StreamController _lastNameStreamController = StreamController<String>.broadcast();
  StreamController _dobStreamController = StreamController<String>.broadcast();
  StreamController _isAllInputsValidStreamController = StreamController<void>.broadcast();
  StreamController isUserLoggedInSuccessfullyStreamController = StreamController<
      bool>();

  RegisterUseCase _registerUseCase;
  var registerViewObject = RegisterObject("", "", "", "", "");
  RegisterViewModel(this._registerUseCase);

  @override
  void start() {
    inputState.add(ContentState());
  }

  @override
  // TODO: implement inputUserName
  Sink get inputUserName => _usernameStreamController.sink;

  @override
  // TODO: implement inputPassword
  Sink get inputPassword => _passwordStreamController.sink;

  @override
  // TODO: implement inputFirstName
  Sink get inputFirstName => _firstNameStreamController.sink;

  @override
  // TODO: implement inputLastName
  Sink get inputLastName => _lastNameStreamController.sink;

  @override
  // TODO: implement inputDob
  Sink get inputDob => _dobStreamController.sink;

  @override
  // TODO: implement inputAllInputsValid
  Sink get inputAllInputsValid => _isAllInputsValidStreamController.sink;

  @override
  // TODO: implement outputIsUserNameValid
  Stream<bool> get outputIsUserNameValid =>
      _usernameStreamController.stream.map((username) => _isUserNameValid(username));
  @override
  // TODO: implement outputErrorUserName
  Stream<String?> get outputErrorUserName =>
      outputIsUserNameValid.map((isUserNameValid) => isUserNameValid ? null : "Invalid username");

  @override
  // TODO: implement outputIsPasswordValid
  Stream<bool> get outputIsPasswordValid =>
      _passwordStreamController.stream.map((password) => _isPasswordValid(password));
  @override
  // TODO: implement outputErrorPassword
  Stream<String?> get outputErrorPassword =>
      outputIsPasswordValid.map((isPasswordValid) => isPasswordValid ? null : "Invalid password");

  @override
  // TODO: implement outputIsFirstName
  Stream<bool> get outputIsFirstNameValid =>
      _firstNameStreamController.stream.map((firstName) => _isFirstNameValid(firstName));
  @override
  // TODO: implement outputErrorFirstName
  Stream<String?> get outputErrorFirstName =>
      outputIsFirstNameValid.map((isFirstNameValid) => isFirstNameValid ? null : "Invalid firstname");


  @override
  // TODO: implement outputIsLastName
  Stream<bool> get outputIsLastNameValid =>
      _lastNameStreamController.stream.map((lastName) => _isLastNameValid(lastName));
  @override
  // TODO: implement outputErrorLastName
  Stream<String?> get outputErrorLastName =>
      outputIsLastNameValid.map((isLastNameValid) => isLastNameValid ? null : "Invalid lastname");

  @override
  // TODO: implement outputIsDob
  Stream<bool> get outputIsDob =>
      _dobStreamController.stream.map((dob) => _isDobValid(dob));

  @override
  // TODO: implement outputIsAllInputsValid
  Stream<bool> get outputIsAllInputsValid =>
      _isAllInputsValidStreamController.stream.map((_) => _isAllValid());

  @override
  void dispose() {
    _usernameStreamController.close();
    _passwordStreamController.close();
    _firstNameStreamController.close();
    _lastNameStreamController.close();
    _dobStreamController.close();
    _isAllInputsValidStreamController.close();
    isUserLoggedInSuccessfullyStreamController.close();
    super.dispose();
  }

  @override
  register() async{
    inputState.add(LoadingState(
        stateRendererType: StateRendererType.POPUP_LOADING_STATE));
    (await _registerUseCase.execute(
      RegisterUseCaseInput(
          registerViewObject.username,
          registerViewObject.password,
          registerViewObject.firstName,
          registerViewObject.lastName,
          registerViewObject.dob
      )))
        .fold((failure)=>{
          inputState.add(ErrorState(
              StateRendererType.POPUP_ERROR_STATE, failure.message))
    }, (data){
          inputState.add(ContentState());
          isUserLoggedInSuccessfullyStreamController.add(true);
    });
  }

  @override
  setFirstName(String firstName) {
    inputFirstName.add(firstName);
    if(_isFirstNameValid(firstName)){
      registerViewObject = registerViewObject.copyWith(firstName: firstName);
    }else{
      registerViewObject = registerViewObject.copyWith(firstName: "");
    }
    _validate();
  }

  @override
  setLastName(String lastName) {
    inputLastName.add(lastName);
    if(_isLastNameValid(lastName)){
      registerViewObject = registerViewObject.copyWith(lastName: lastName);
    }else{
      registerViewObject = registerViewObject.copyWith(lastName: "");
    }
    _validate();
  }

  @override
  setPassword(String password) {
    inputPassword.add(password);
    if(_isPasswordValid(password)){
      registerViewObject = registerViewObject.copyWith(password: password);
    }else{
      registerViewObject = registerViewObject.copyWith(password: "");
    }
    _validate();
  }

  @override
  setUserName(String username) {
    inputUserName.add(username);
    if(_isUserNameValid(username)){
      registerViewObject = registerViewObject.copyWith(username: username);
    }else{
      registerViewObject = registerViewObject.copyWith(username: "");
    }
    _validate();
  }

  @override
  setDob(String dob) {
    inputDob.add(dob);
    if(_isDobValid(dob)){
      registerViewObject = registerViewObject.copyWith(dob: dob);
    }else{
      registerViewObject = registerViewObject.copyWith(dob: "");
    }
    _validate();
  }

  bool _isUserNameValid(String username){
    return username.length >= 8;
  }
  bool _isPasswordValid(String password){
    return password.length >= 8;
  }
  bool _isFirstNameValid(String firstName){
    return firstName.length >= 4;
  }
  bool _isLastNameValid(String lastName){
    return lastName.length >= 4;
  }
  bool _isDobValid(String dob){
    return dob.isNotEmpty;
  }
  bool _isAllValid(){
    return registerViewObject.username.isNotEmpty && registerViewObject.password.isNotEmpty
          && registerViewObject.firstName.isNotEmpty && registerViewObject.lastName.isNotEmpty
          && registerViewObject.dob.isNotEmpty;
  }
  _validate(){
    inputAllInputsValid.add(null);
  }

}

abstract class RegisterViewModelInput{
  register();
  setUserName(String username);
  setPassword(String password);
  setFirstName(String firstName);
  setLastName(String lastName);
  setDob(String dob);
  Sink get inputUserName;
  Sink get inputPassword;
  Sink get inputFirstName;
  Sink get inputLastName;
  Sink get inputDob;
  Sink get inputAllInputsValid;
}

abstract class RegisterViewModelOutput{
  Stream<bool> get outputIsUserNameValid;
  Stream<String?> get outputErrorUserName;
  Stream<bool> get outputIsPasswordValid;
  Stream<String?> get outputErrorPassword;
  Stream<bool> get outputIsFirstNameValid;
  Stream<String?> get outputErrorFirstName;
  Stream<bool> get outputIsLastNameValid;
  Stream<String?> get outputErrorLastName;
  Stream<bool> get outputIsDob;
  Stream<bool> get outputIsAllInputsValid;
}
