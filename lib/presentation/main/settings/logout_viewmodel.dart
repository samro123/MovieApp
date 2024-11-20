import 'dart:async';

import 'package:movie_video/domain/usecase/logout_usecase.dart';
import 'package:movie_video/presentation/base/baseviewmodel.dart';

class LogoutViewModel extends BaseViewModel implements LogoutInput{
  final StreamController _tokenStreamController = StreamController<void>.broadcast();
  final LogoutUseCase _logoutUseCase;
  LogoutViewModel(this._logoutUseCase);
  var token = "";

  @override
  // TODO: implement inputToken
  Sink get inputToken => _tokenStreamController.sink;

  @override
  logout() async{
    (await _logoutUseCase.execute(token)).fold(
            (failure){
              print(failure);
            }, (r) => null);
  }

  @override
  setToken(String token) {
    inputToken.add(token);
    this.token = token;
  }

  @override
  void start() {
    // TODO: implement start
  }

  @override
  void dispose() {
    _tokenStreamController.close();
  }

}
abstract class LogoutInput{
  logout();
  setToken(String token);
  Sink get inputToken;
}