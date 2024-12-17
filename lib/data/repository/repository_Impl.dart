import 'package:dartz/dartz.dart';
import 'package:movie_video/data/data_source/local_data_source.dart';
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
  LocalDataSource _localDataSource;
  NetWorkInfo _networkInfo;
  RepositoryImpl(this._remoteDataSource,this._localDataSource, this._networkInfo);
  @override
  Future<Either<Failure, Authentication>> login(LoginRequest loginRequest) async {
    if(await _networkInfo.isConnected){
    try{
      //it safe to call the API
      final response = await _remoteDataSource.login(loginRequest);
      print(response);
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

  @override
  Future<Either<Failure, Comment>> comment(String movieId, String comment) async{
    if(await _networkInfo.isConnected){
      try{
        final response = await _remoteDataSource.comment(movieId, comment);
        if(response.code == ApiInternalStatus.SUCCESS){
          return Right(response.toDomain());
        }else{
          return Left(Failure(response.code ?? ResponseCode.DEFAULT,
              response.message ?? ResponseMessage.DEFAULT));
        }
      }catch(error, stackTrace){
        print('Caught exception: $error');
        print('Stack track: $stackTrace');
        return Left(ErrorHandler.handle(error).failure);
      }
    }else{
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, PaginatedMovies>> getPaginatedMovies(int page, int size) async {
    try{
      final response = await _localDataSource.getMovie();
      return Right(response.toDomain());
    }catch(cacheError){
      if(await _networkInfo.isConnected){
        try{
          final response = await _remoteDataSource.getPaginatedMovie(page, size);
          if(response.code == ApiInternalStatus.SUCCESS){
            _localDataSource.saveMovieToCache(response);
            return Right(response.toDomain());
          }else{
            return Left(Failure(response.code ?? ApiInternalStatus.FAILURE,
                        response.message ?? ResponseMessage.DEFAULT
            ));
          }
        }catch(error){
          return (Left(ErrorHandler.handle(error).failure));
        }
      }else{
        return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      }
    }
  }

  @override
  Future<Either<Failure, RecommendMovies>> getRecommendMovies() async{
    try{
      final response = await _localDataSource.getRecommendMovies();
      return Right(response.toDomain());
    }catch(cacheError){
      if(await _networkInfo.isConnected){
        try{
          final response = await _remoteDataSource.getRecommendMovies();
          if(response.code == ApiInternalStatus.SUCCESS){
            _localDataSource.saveRecommendMoviesToCache(response);
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
  }

  @override
  Future<Either<Failure, GetComments>> getComments(String movieId) async{
    try{
      final response = await _localDataSource.getComment();
      return Right(response.toDomain());
    }catch(cacheError){
      if(await _networkInfo.isConnected){
        try{
          final response = await _remoteDataSource.getComment(movieId);
          if(response.code == ApiInternalStatus.SUCCESS){
            _localDataSource.saveCommentToCache(response);
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
  }

  @override
  Future<Either<Failure, String>> logout(String token) async{
    if(await _networkInfo.isConnected){
      try{
        final response = await _remoteDataSource.logout(token);
        if(response.code == ApiInternalStatus.SUCCESS){
          return Right(response.code.toString());
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
  Future<Either<Failure, Profile>> updateProfile(ProfileRequest profileRequest) async{
    if(await _networkInfo.isConnected){
      try{
        final response = await _remoteDataSource.updateProfile(profileRequest);
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
  Future<Either<Failure, Profile>> getProfile() async{
    if(await _networkInfo.isConnected){
      try{
        final response = await _remoteDataSource.getProfile();
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



}