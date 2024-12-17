import 'dart:io';

import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'freezed_data_classes.freezed.dart';
@freezed
class LoginObject with _$LoginObject{
  factory LoginObject(String username, String password) = _LoginObject;
}
@freezed
class RegisterObject with _$RegisterObject{
  factory RegisterObject(
      String username, String password,
      String firstName, String lastName,
      String dob
      ) = _RegisterObject;
}
@freezed
class ProfileObject with _$ProfileObject{
  factory ProfileObject(
      String username, String firstName,
      String lastName, File? avatar, String dob,
      String city
      ) = _ProfileObject;
}