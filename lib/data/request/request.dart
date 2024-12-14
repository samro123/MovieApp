import 'dart:io';

import 'package:dio/dio.dart';

class LoginRequest{
  String username;
  String password;
  LoginRequest(this.username, this.password);
}

class RegisterRequest{
  String username;
  String password;
  String firstName;
  String lastName;
  String dob;
  RegisterRequest(this.username, this.password, this.firstName, this.lastName, this.dob);
}

class CommentRequest{
  String content;
  CommentRequest(this.content);
}

class ProfileRequest{
  String username;
  String firstName;
  String lastName;
  MultipartFile avatar;
  String dob;
  String city;
  ProfileRequest(this.username, this.firstName, this.lastName, this.avatar, this.dob, this.city);
}
