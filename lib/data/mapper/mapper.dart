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
extension RolesResponseMapper on RoleResponse?{
  Roles toDomain(){
    return Roles(
        this?.name?.orEmpty() ?? EMPTY,
        this?.description?.orEmpty() ?? EMPTY,
        (this?.permissions?.map((permissions) => permissions) ?? Iterable.empty()).cast<String>().toList()
    );
  }
}
extension RegisterAuthenticationResponseMapper on RegisterAuthResponse?{
  RegisterAuthentication toDomain(){
    List<Roles> mapRoles = (this?.result?.roles?.map((roles) => roles.toDomain())
        ?? Iterable.empty()).cast<Roles>().toList();
    return RegisterAuthentication(
        this?.result?.id?.orEmpty() ?? EMPTY,
        this?.result?.username?.orEmpty() ?? EMPTY,
        mapRoles);
  }
}