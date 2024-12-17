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
      json['expiryTime'] as String?,
    );

Map<String, dynamic> _$ResultResponseToJson(ResultResponse instance) =>
    <String, dynamic>{
      'token': instance.token,
      'expiryTime': instance.expiryTime,
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

MovieResponse _$MovieResponseFromJson(Map<String, dynamic> json) =>
    MovieResponse(
      json['id'] as String?,
      json['title'] as String?,
      json['category'] as String?,
      json['description'] as String?,
      json['trailerUrl'] as String?,
      json['videoUrl'] as String?,
      json['posterUrl'] as String?,
      json['createdDate'] as String?,
      json['modifiedDate'] as String?,
    );

Map<String, dynamic> _$MovieResponseToJson(MovieResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'category': instance.category,
      'description': instance.description,
      'trailerUrl': instance.trailerUrl,
      'videoUrl': instance.videoUrl,
      'posterUrl': instance.posterUrl,
      'createdDate': instance.createdDate,
      'modifiedDate': instance.modifiedDate,
    };

MovieResultResponse _$MovieResultResponseFromJson(Map<String, dynamic> json) =>
    MovieResultResponse(
      (json['currentPage'] as num?)?.toInt(),
      (json['totalPages'] as num?)?.toInt(),
      (json['pageSize'] as num?)?.toInt(),
      (json['totalElements'] as num?)?.toInt(),
      (json['data'] as List<dynamic>?)
          ?.map((e) => MovieResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MovieResultResponseToJson(
        MovieResultResponse instance) =>
    <String, dynamic>{
      'currentPage': instance.currentPage,
      'totalPages': instance.totalPages,
      'pageSize': instance.pageSize,
      'totalElements': instance.totalElements,
      'data': instance.data,
    };

PaginatedMoviesResponse _$PaginatedMoviesResponseFromJson(
        Map<String, dynamic> json) =>
    PaginatedMoviesResponse(
      (json['code'] as num?)?.toInt(),
      json['message'] as String?,
      json['result'] == null
          ? null
          : MovieResultResponse.fromJson(
              json['result'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PaginatedMoviesResponseToJson(
        PaginatedMoviesResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'result': instance.result,
    };

RecommendMoviesResponse _$RecommendMoviesResponseFromJson(
        Map<String, dynamic> json) =>
    RecommendMoviesResponse(
      (json['code'] as num?)?.toInt(),
      json['message'] as String?,
      (json['result'] as List<dynamic>?)
          ?.map((e) => MovieResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RecommendMoviesResponseToJson(
        RecommendMoviesResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'result': instance.result,
    };

CommentResult _$CommentResultFromJson(Map<String, dynamic> json) =>
    CommentResult(
      json['id'] as String?,
      json['movieId'] as String?,
      json['userId'] as String?,
      json['username'] as String?,
      json['content'] as String?,
      json['avatar'] as String?,
      json['created'] as String?,
      json['createdDate'] as String?,
      json['modifiedDate'] as String?,
    );

Map<String, dynamic> _$CommentResultToJson(CommentResult instance) =>
    <String, dynamic>{
      'id': instance.id,
      'movieId': instance.movieId,
      'userId': instance.userId,
      'username': instance.username,
      'content': instance.content,
      'avatar': instance.avatar,
      'created': instance.created,
      'createdDate': instance.createdDate,
      'modifiedDate': instance.modifiedDate,
    };

CommentResponse _$CommentResponseFromJson(Map<String, dynamic> json) =>
    CommentResponse(
      (json['code'] as num?)?.toInt(),
      json['message'] as String?,
      json['result'] == null
          ? null
          : CommentResult.fromJson(json['result'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CommentResponseToJson(CommentResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'result': instance.result,
    };

GetCommentResponse _$GetCommentResponseFromJson(Map<String, dynamic> json) =>
    GetCommentResponse(
      (json['code'] as num?)?.toInt(),
      json['message'] as String?,
      (json['result'] as List<dynamic>?)
          ?.map((e) => CommentResult.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetCommentResponseToJson(GetCommentResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'result': instance.result,
    };

ProfileResultResponse _$ProfileResultResponseFromJson(
        Map<String, dynamic> json) =>
    ProfileResultResponse(
      json['username'] as String?,
      json['firstName'] as String?,
      json['lastName'] as String?,
      json['avatar'] as String?,
      json['dob'] as String?,
      json['city'] as String?,
    );

Map<String, dynamic> _$ProfileResultResponseToJson(
        ProfileResultResponse instance) =>
    <String, dynamic>{
      'username': instance.username,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'avatar': instance.avatar,
      'dob': instance.dob,
      'city': instance.city,
    };

ProfileResponse _$ProfileResponseFromJson(Map<String, dynamic> json) =>
    ProfileResponse(
      (json['code'] as num?)?.toInt(),
      json['message'] as String?,
      json['result'] == null
          ? null
          : ProfileResultResponse.fromJson(
              json['result'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProfileResponseToJson(ProfileResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'result': instance.result,
    };
