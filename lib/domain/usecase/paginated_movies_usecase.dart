import 'package:dartz/dartz.dart';
import 'package:movie_video/data/network/failure.dart';
import 'package:movie_video/domain/model/model.dart';
import 'package:movie_video/domain/repository/repository.dart';
import 'package:movie_video/domain/usecase/base_usecase.dart';

class PaginatedMoviesUseCase extends BaseUseCase<PaginatedMoviesParams, PaginatedMovies>{
  Repository _repository;
  PaginatedMoviesUseCase(this._repository);

  @override
  Future<Either<Failure, PaginatedMovies>> execute(PaginatedMoviesParams params) async{
    return await _repository.getPaginatedMovies(params.page, params.size);
  }

}


class PaginatedMoviesParams{
  final int page;
  final int size;
  PaginatedMoviesParams(this.page, this.size);
}

