import 'package:dartz/dartz.dart';
import 'package:movie_video/data/network/failure.dart';
import 'package:movie_video/data/request/request.dart';
import 'package:movie_video/domain/model/model.dart';
abstract class Repository{
  Future<Either<Failure, Authentication>> login(LoginRequest loginRequest);
  Future<Either<Failure, String>> forgotPassword(String email);
  Future<Either<Failure, RegisterAuthentication>> register(RegisterRequest registerRequest);
  Future<Either<Failure, PaginatedMovies>> getPaginatedMovies(int page, int size);
  Future<Either<Failure, Comment>> comment(String movieId, String comment);
  Future<Either<Failure, GetComments>> getComments(String movieId);
}