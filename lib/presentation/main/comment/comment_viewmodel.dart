import 'dart:async';

import 'package:movie_video/domain/usecase/comment_usecase.dart';
import 'package:movie_video/presentation/base/baseviewmodel.dart';

class CommentViewModel extends BaseViewModel implements CommentInput{
  final StreamController _contentStreamController =
      StreamController<String>.broadcast();
  final StreamController _movieIdPathStreamController =
      StreamController<String>.broadcast();

  final CommentUseCase _commentUseCase;
  CommentViewModel(this._commentUseCase);
  var movieIdPath = "";
  var content = "";
  @override
  void start() {
  }
  @override
  comment() async{
    (await _commentUseCase.execute(
        CommentUseCaseInput(movieIdPath, content)))
        .fold((failure){
          print(failure);
    }, (data){

    });
  }

  @override
  // TODO: implement inputComment
  Sink get inputComment => _contentStreamController.sink;

  @override
  // TODO: implement inputMovieIdPath
  Sink get inputMovieIdPath => _movieIdPathStreamController.sink;

  @override
  setCommentContent(String content) {
    inputComment.add(content);
    this.content = content;
  }

  @override
  setMovieIdPath(String movieIdPath) {
    inputMovieIdPath.add(movieIdPath);
    this.movieIdPath = movieIdPath;
  }

  @override
  void dispose() {
    _contentStreamController.close();
    _movieIdPathStreamController.close();
    super.dispose();
  }

}
abstract class CommentInput{
  comment();
  setCommentContent(String content);
  setMovieIdPath(String movieIdPath);
  Sink get inputComment;
  Sink get inputMovieIdPath;
}