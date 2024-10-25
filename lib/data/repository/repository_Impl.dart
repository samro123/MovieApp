import 'package:dartz/dartz.dart';
import 'package:movie_video/data/data_source/remote_data_source.dart';
import 'package:movie_video/data/mapper/mapper.dart';
import 'package:movie_video/data/network/error_handler.dart';
import 'package:movie_video/data/network/failure.dart';
import 'package:movie_video/data/network/network_info.dart';
import 'package:movie_video/data/request/request.dart';
import 'package:movie_video/domain/model/model.dart';
import 'package:movie_video/domain/repository/repository.dart';

class RepositoryImpl extends Repository{
  RemoteDataSource _remoteDataSource;
  NetWorkInfo _networkInfo;
  RepositoryImpl(this._remoteDataSource, this._networkInfo);
  @override
  Future<Either<Failure, Authentication>> login(LoginRequest loginRequest) async {
    if(await _networkInfo.isConnected){
    try{
      //it safe to call the API
      final response = await _remoteDataSource.login(loginRequest);
      if(response.code == ApiInternalStatus.SUCCESS){
        //return data success)
        //return right
        return Right(response.toDomain());
      }else{
        return Left(Failure(
            0,
            response.message ?? ResponseMessage.DEFAULT));
      }
    }catch(error, stackTrace){
      print('Caught exception: $error');
      print('Stack track: $stackTrace');
      return (Left(ErrorHandler.handle(error).failure));
    }
    }else{
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, String>> forgotPassword(String email) async{
    if(await _networkInfo.isConnected){
      try{
        final response = await _remoteDataSource.forgotPassword(email);
        if(response.code == ApiInternalStatus.SUCCESS){
          return Right(response.toDomain());
        }else{
          return Left(Failure(response.code ?? ResponseCode.DEFAULT,
              response.message ?? ResponseMessage.DEFAULT));
        }
      }catch(error){
        return Left(ErrorHandler.handle(error).failure);
      }
    }else{
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, RegisterAuthentication>> register(RegisterRequest registerRequest) async{
    if(await _networkInfo.isConnected){
      try{
        final response = await _remoteDataSource.register(registerRequest);
        if(response.code == ApiInternalStatus.SUCCESS){
          return Right(response.toDomain());
        }else{
          return Left(Failure(response.code ?? ResponseCode.DEFAULT,
              response.message ?? ResponseMessage.DEFAULT));
        }
      }catch(error,stackTrace){
        print('Caught exception: $error');
        print('Stack trace: $stackTrace');
        return Left(ErrorHandler.handle(error).failure);
      }
    }else{
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }
  
}