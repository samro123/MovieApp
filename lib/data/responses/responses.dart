import 'package:json_annotation/json_annotation.dart';
part 'responses.g.dart';

@JsonSerializable()
class BaseResponse {
  @JsonKey(name: "code")
  int? code;

  @JsonKey(name: "message")
  String? message;

  BaseResponse(this.code, this.message);

  // from json
  factory BaseResponse.fromJson(Map<String, dynamic> json) =>
      _$BaseResponseFromJson(json);

  // to json
  Map<String, dynamic> toJson() => _$BaseResponseToJson(this);
}

@JsonSerializable()
class ResultResponse {
  @JsonKey(name: "token")
  String? token;

  @JsonKey(name: "authenticated")
  bool? authenticated;

  ResultResponse(this.token, this.authenticated);

  // from json
  factory ResultResponse.fromJson(Map<String, dynamic> json) =>
      _$ResultResponseFromJson(json);

  // to json
  Map<String, dynamic> toJson() => _$ResultResponseToJson(this);
}

@JsonSerializable()
class AuthenticationResponse extends BaseResponse {
  @JsonKey(name: "result")
  ResultResponse? result;

  AuthenticationResponse(int? code, String? message, this.result) : super(code, message);

  // from json
  factory AuthenticationResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthenticationResponseFromJson(json);

  // to json
  Map<String, dynamic> toJson() => _$AuthenticationResponseToJson(this);
}

@JsonSerializable()
class ForgotPasswordResponse extends BaseResponse {
  @JsonKey(name: 'support')
  String? support;

  ForgotPasswordResponse(int? code, String? message,this.support):super(code, message);

// toJson
  Map<String, dynamic> toJson() => _$ForgotPasswordResponseToJson(this);

//fromJson
  factory ForgotPasswordResponse.fromJson(Map<String, dynamic> json) =>
      _$ForgotPasswordResponseFromJson(json);
}

// register.
@JsonSerializable()
class RoleResponse{
  @JsonKey(name: 'name')
  String? name;

  @JsonKey(name: 'description')
  String? description;

  @JsonKey(name: 'permissions')
  List<String>? permissions;
  RoleResponse(this.name, this.description, this.permissions);

  Map<String, dynamic> toJson() => _$RoleResponseToJson(this);
  factory RoleResponse.fromJson(Map<String, dynamic> json) =>
      _$RoleResponseFromJson(json);
}

@JsonSerializable()
class RegisterResultResponse{
  @JsonKey(name:'id')
  String? id;

  @JsonKey(name: 'username')
  String? username;

  @JsonKey(name: 'roles')
  List<RoleResponse>? roles;
  RegisterResultResponse(this.id, this.username, this.roles);


  factory RegisterResultResponse.fromJson(Map<String, dynamic> json) =>
      _$RegisterResultResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterResultResponseToJson(this);
}

@JsonSerializable()
class RegisterAuthResponse extends BaseResponse{
  @JsonKey(name:'result')
  RegisterResultResponse? result;

  RegisterAuthResponse(int? code,String? message, this.result):super(code, message);

  factory RegisterAuthResponse.fromJson(Map<String, dynamic> json) =>
      _$RegisterAuthResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterAuthResponseToJson(this);
}
