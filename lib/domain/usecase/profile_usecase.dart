import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:movie_video/data/network/failure.dart';
import 'package:movie_video/data/request/request.dart';
import 'package:movie_video/domain/model/model.dart';
import 'package:movie_video/domain/repository/repository.dart';
import 'package:movie_video/domain/usecase/base_usecase.dart';
import 'package:movie_video/domain/usecase/register_usecase.dart';

class UpdateProfileUseCase implements BaseUseCase<ProfileUseCaseInput, Profile>{
  Repository _repository;
  UpdateProfileUseCase(this._repository);
  @override
  Future<Either<Failure, Profile>> execute(ProfileUseCaseInput input) async{
    return await _repository.updateProfile(ProfileRequest(
      input.username, input.firstName,
      input.lastName, input.avatar, input.dob,
      input.city
    ));
  }

}
class GetProfileUseCase implements BaseUseCase<void, Profile>{
  Repository _repository;
  GetProfileUseCase(this._repository);
  @override
  Future<Either<Failure, Profile>> execute(void input) async{
    return await _repository.getProfile();
  }

}
class ProfileUseCaseInput{
  String username;
  String firstName;
  String lastName;
  MultipartFile avatar;
  String dob;
  String city;
  ProfileUseCaseInput(
      this.username, this.firstName,
      this.lastName,this.avatar, this.dob,
      this.city
      );
}