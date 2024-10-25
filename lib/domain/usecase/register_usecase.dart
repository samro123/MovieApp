import 'package:dartz/dartz.dart';
import 'package:movie_video/data/network/failure.dart';
import 'package:movie_video/data/request/request.dart';
import 'package:movie_video/domain/model/model.dart';
import 'package:movie_video/domain/repository/repository.dart';
import 'package:movie_video/domain/usecase/base_usecase.dart';

class RegisterUseCase implements BaseUseCase<RegisterUseCaseInput, RegisterAuthentication>{
  Repository _repository;
  RegisterUseCase(this._repository);
  @override
  Future<Either<Failure, RegisterAuthentication>> execute(RegisterUseCaseInput input) async{
      return await _repository.register(RegisterRequest(
          input.username, input.password,
          input.firstName, input.lastName,
          input.dob));
  }

}

class RegisterUseCaseInput{
  String username;
  String password;
  String firstName;
  String lastName;
  String dob;
  RegisterUseCaseInput(
      this.username, this.password,
      this.firstName, this.lastName,
      this.dob
      );
}
