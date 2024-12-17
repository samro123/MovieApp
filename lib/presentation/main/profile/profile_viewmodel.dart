import 'dart:async';
import 'dart:ffi';
import 'dart:io';
import 'package:movie_video/domain/model/model.dart';
import 'package:movie_video/domain/usecase/profile_usecase.dart';
import 'package:movie_video/presentation/base/baseviewmodel.dart';
import 'package:movie_video/presentation/common/freezed_data_classes.dart';
import 'package:movie_video/presentation/common/state_renderer/state_renderer.dart';
import 'package:movie_video/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:rxdart/subjects.dart';

class ProfileViewModel extends BaseViewModel
    implements ProfileViewModelInput, ProfileViewModelOutput{
  StreamController _usernameStreamController = StreamController<String>.broadcast();
  StreamController _firstNameStreamController = StreamController<String>.broadcast();
  StreamController _lastNameStreamController = StreamController<String>.broadcast();
  StreamController _dobStreamController = StreamController<String>.broadcast();
  StreamController _cityStreamController = StreamController<String>.broadcast();
  StreamController _isAllInputsValidStreamController = StreamController<void>.broadcast();
  StreamController _profilePictureStreamController = StreamController<File>.broadcast();
  UpdateProfileUseCase _updateProfileUseCase;
  GetProfileUseCase _getProfileUseCase;
  final _dataStreamController = BehaviorSubject<GetProfileViewObject>();
  var profileViewObject = ProfileObject("", "", "", null, "", "");
  ProfileViewModel(this._updateProfileUseCase, this._getProfileUseCase);

  @override
  void start() {
    inputState.add(ContentState());
    _getProfile();
  }
  @override
  // TODO: implement inputAllInputsValid
  Sink get inputAllInputsValid => _isAllInputsValidStreamController.sink;

  @override
  // TODO: implement inputCity
  Sink get inputCity => _cityStreamController.sink;

  @override
  // TODO: implement inputDob
  Sink get inputDob => _dobStreamController.sink;

  @override
  // TODO: implement inputFirstName
  Sink get inputFirstName => _firstNameStreamController.sink;

  @override
  // TODO: implement inputLastName
  Sink get inputLastName => _lastNameStreamController.sink;

  @override
  // TODO: implement inputUserName
  Sink get inputUserName => _usernameStreamController.sink;

  @override
  // TODO: implement inputProfileData
  Sink get inputProfileData => _dataStreamController.sink;

  @override
  // TODO: implement outputIsUserNameValid
  Stream<bool> get outputIsUserNameValid =>
      _usernameStreamController.stream.map((username) => _isUserNameValid(username));
  @override
  // TODO: implement outputErrorUserName
  Stream<String?> get outputErrorUserName =>
      outputIsUserNameValid.map((isUserNameValid) => isUserNameValid ? null : "Invalid username");

  @override
  // TODO: implement outputIsFirstName
  Stream<bool> get outputIsFirstNameValid =>
      _firstNameStreamController.stream.map((firstName) => _isFirstNameValid(firstName));
  @override
  // TODO: implement outputErrorFirstName
  Stream<String?> get outputErrorFirstName =>
      outputIsFirstNameValid.map((isFirstNameValid) => isFirstNameValid ? null : "Invalid firstname");

  @override
  // TODO: implement outputIsLastNameValid
  Stream<bool> get outputIsLastNameValid =>
      _lastNameStreamController.stream.map((lastName) => _isLastNameValid(lastName));
  @override
  // TODO: implement outputErrorLastName
  Stream<String?> get outputErrorLastName =>
      outputIsLastNameValid.map((isLastNameValid) => isLastNameValid ? null : "Invalid lastname");

  @override
  // TODO: implement outputIsCity
  Stream<bool> get outputIsCity =>
      _cityStreamController.stream.map((city) => _isCityValid(city));

  @override
  // TODO: implement outputIsDob
  Stream<bool> get outputIsDob =>
      _dobStreamController.stream.map((dob) => _isDobValid(dob));

  @override
  // TODO: implement outputIsAllInputsValid
  Stream<bool> get outputIsAllInputsValid =>
      _isAllInputsValidStreamController.stream.map((_) => _isAllValid());

  @override
  // TODO: implement outputProfileData
  Stream<GetProfileViewObject> get outputProfileData =>
      _dataStreamController.stream.map((data) => data);

  @override
  updateProfile() async{
    inputState.add(
      LoadingState(stateRendererType: StateRendererType.POPUP_LOADING_STATE));
    (await _updateProfileUseCase.execute(ProfileUseCaseInput(
        profileViewObject.username, profileViewObject.firstName,
        profileViewObject.lastName, profileViewObject.avatar!, profileViewObject.dob,
        profileViewObject.city))).fold((failure){
          inputState.add(ErrorState(StateRendererType.POPUP_ERROR_STATE, failure.message));
    }, (profile) => inputState.add(SuccessState("Update Success")));
  }

  _getProfile() async{
    (await _getProfileUseCase.execute(Void)).fold((failure){
      print(failure);
    }, (profileObject){
      inputProfileData.add(GetProfileViewObject(profileObject));
    });
  }
  
  @override
  void dispose() {
    _usernameStreamController.close();
    _firstNameStreamController.close();
    _lastNameStreamController.close();
    _profilePictureStreamController.close();
    _dobStreamController.close();
    _cityStreamController.close();
    _isAllInputsValidStreamController.close();
    _dataStreamController.close();
    super.dispose();
  }
  
  @override
  setCity(String city) {
    inputCity.add(city);
    if(_isCityValid(city)){
      profileViewObject = profileViewObject.copyWith(city: city);
    }else{
      profileViewObject = profileViewObject.copyWith(city: "");
    }
    _validate();
  }

  @override
  setDob(String dob) {
    inputDob.add(dob);
    if(_isDobValid(dob)){
      profileViewObject = profileViewObject.copyWith(dob: dob);
    }else{
      profileViewObject = profileViewObject.copyWith(dob: "");
    }
    _validate();
  }

  @override
  setFirstName(String firstName) {
    inputFirstName.add(firstName);
    if(_isFirstNameValid(firstName)){
      profileViewObject = profileViewObject.copyWith(firstName: firstName);
    }else{
      profileViewObject = profileViewObject.copyWith(firstName: "");
    }
    _validate();
  }

  @override
  setLastName(String lastName) {
    inputLastName.add(lastName);
    if(_isLastNameValid(lastName)){
      profileViewObject = profileViewObject.copyWith(lastName: lastName);
    }else{
      profileViewObject = profileViewObject.copyWith(lastName: "");
    }
    _validate();
  }

  @override
  setUserName(String username) {
    inputUserName.add(username);
    if(_isUserNameValid(username)){
      profileViewObject = profileViewObject.copyWith(username: username);
    }else{
      profileViewObject = profileViewObject.copyWith(username: "");
    }
    _validate();
  }



  bool _isUserNameValid(String username){
    return username.length >= 8;
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
  bool _isCityValid(String city){
    return city.isNotEmpty;
  }
  bool _isAllValid(){
    return profileViewObject.username.isNotEmpty && profileViewObject.firstName.isNotEmpty
        && profileViewObject.lastName.isNotEmpty && profileViewObject.dob.isNotEmpty
        && profileViewObject.city.isNotEmpty;
  }
  _validate(){
    inputAllInputsValid.add(null);
  }

  @override
  // TODO: implement inputProfilePicture
  Sink get inputProfilePicture => _profilePictureStreamController.sink;

  @override
  // TODO: implement outputProfilePicture
  Stream<File?> get outputProfilePicture =>  _profilePictureStreamController.stream.map((file) => file);

  @override
  setProfilePicture(File profilePictures) {
    inputProfilePicture.add(profilePictures);
    if(profilePictures.path.isNotEmpty){
      //update register view object with username value
      profileViewObject = profileViewObject.copyWith(avatar: profilePictures); // using data class like kotlin
    }
    else{
      //reset username value in register view object
      profileViewObject = profileViewObject.copyWith(avatar: null); // using data class like kotlin

    }
    _validate();
  }

}
 abstract class ProfileViewModelInput{
  updateProfile();
  setUserName(String username);
  setFirstName(String firstName);
  setLastName(String lastName);
  setProfilePicture(File file);
  setDob(String dob);
  setCity(String city);
  Sink get inputUserName;
  Sink get inputFirstName;
  Sink get inputLastName;
  Sink get inputProfilePicture;
  Sink get inputDob;
  Sink get inputCity;
  Sink get inputAllInputsValid;
  Sink get inputProfileData;
}

abstract class ProfileViewModelOutput{
  Stream<bool> get outputIsUserNameValid;
  Stream<String?> get outputErrorUserName;
  Stream<bool> get outputIsFirstNameValid;
  Stream<String?> get outputErrorFirstName;
  Stream<bool> get outputIsLastNameValid;
  Stream<String?> get outputErrorLastName;
  Stream<File?> get outputProfilePicture;
  Stream<bool> get outputIsDob;
  Stream<bool> get outputIsCity;
  Stream<bool> get outputIsAllInputsValid;
  Stream<GetProfileViewObject> get outputProfileData;
}

class GetProfileViewObject{
  Profile profile;
  GetProfileViewObject(this.profile);
}