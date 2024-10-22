import 'package:movie_video/app/extensions.dart';
import 'package:movie_video/data/responses/responses.dart';
import 'package:movie_video/domain/model/model.dart';

const EMPTY = "";
const ZERO = 0;
extension AuthenticationResponseMapper on AuthenticationResponse?{
  Authentication toDomain(){
    return Authentication(
        this?.result?.token?.orEmpty() ?? EMPTY,
        (this?.result?.authenticated ?? false)
    );
  }
}
extension ForgotPasswordResponseMapper on ForgotPasswordResponse?{
  String toDomain(){
    return this?.support?.orEmpty() ?? EMPTY;
  }
}