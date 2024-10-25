// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'responses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseResponse _$BaseResponseFromJson(Map<String, dynamic> json) => BaseResponse(
      (json['code'] as num?)?.toInt(),
      json['message'] as String?,
    );

Map<String, dynamic> _$BaseResponseToJson(BaseResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
    };

ResultResponse _$ResultResponseFromJson(Map<String, dynamic> json) =>
    ResultResponse(
      json['token'] as String?,
      json['authenticated'] as bool?,
    );

Map<String, dynamic> _$ResultResponseToJson(ResultResponse instance) =>
    <String, dynamic>{
      'token': instance.token,
      'authenticated': instance.authenticated,
    };

AuthenticationResponse _$AuthenticationResponseFromJson(
        Map<String, dynamic> json) =>
    AuthenticationResponse(
      (json['code'] as num?)?.toInt(),
      json['message'] as String?,
      json['result'] == null
          ? null
          : ResultResponse.fromJson(json['result'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AuthenticationResponseToJson(
        AuthenticationResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'result': instance.result,
    };

ForgotPasswordResponse _$ForgotPasswordResponseFromJson(
        Map<String, dynamic> json) =>
    ForgotPasswordResponse(
      (json['code'] as num?)?.toInt(),
      json['message'] as String?,
      json['support'] as String?,
    );

Map<String, dynamic> _$ForgotPasswordResponseToJson(
        ForgotPasswordResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'support': instance.support,
    };

RoleResponse _$RoleResponseFromJson(Map<String, dynamic> json) => RoleResponse(
      json['name'] as String?,
      json['description'] as String?,
      (json['permissions'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$RoleResponseToJson(RoleResponse instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'permissions': instance.permissions,
    };

RegisterResultResponse _$RegisterResultResponseFromJson(
        Map<String, dynamic> json) =>
    RegisterResultResponse(
      json['id'] as String?,
      json['username'] as String?,
      (json['roles'] as List<dynamic>?)
          ?.map((e) => RoleResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RegisterResultResponseToJson(
        RegisterResultResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'roles': instance.roles,
    };

RegisterAuthResponse _$RegisterAuthResponseFromJson(
        Map<String, dynamic> json) =>
    RegisterAuthResponse(
      (json['code'] as num?)?.toInt(),
      json['message'] as String?,
      json['result'] == null
          ? null
          : RegisterResultResponse.fromJson(
              json['result'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RegisterAuthResponseToJson(
        RegisterAuthResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'result': instance.result,
    };
