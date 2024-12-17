import 'package:dartz/dartz.dart';
import 'package:movie_video/data/network/failure.dart';
import 'package:movie_video/domain/model/model.dart';
import 'package:movie_video/domain/usecase/base_usecase.dart';

import '../repository/repository.dart';

class RecommendMoviesUseCase implements BaseUseCase<void, RecommendMovies> {
  Repository _repository;
  RecommendMoviesUseCase(this._repository);

  @override
  Future<Either<Failure, RecommendMovies>> execute(void input) async{
    return await _repository.getRecommendMovies();
  }

}