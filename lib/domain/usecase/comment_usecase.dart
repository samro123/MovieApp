import 'package:dartz/dartz.dart';
import 'package:movie_video/data/network/failure.dart';
import 'package:movie_video/data/request/request.dart';
import 'package:movie_video/domain/model/model.dart';
import 'package:movie_video/domain/repository/repository.dart';
import 'package:movie_video/domain/usecase/base_usecase.dart';

class CommentUseCase implements BaseUseCase<CommentUseCaseInput, Comment>{
  Repository _repository;
  CommentUseCase(this._repository);
  @override
  Future<Either<Failure, Comment>> execute(CommentUseCaseInput input) async{
    return await _repository.comment(
        input.movieIdPath,
        input.commentContentInput);
  }

}
class CommentUseCaseInput{
  String movieIdPath;
  String commentContentInput;

  CommentUseCaseInput(this.movieIdPath, this.commentContentInput);
}