import 'dart:async';

import 'package:movie_video/domain/model/model.dart';
import 'package:movie_video/domain/usecase/comment_usecase.dart';
import 'package:movie_video/presentation/base/baseviewmodel.dart';
import 'package:movie_video/presentation/common/state_renderer/state_renderer.dart';
import 'package:movie_video/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:rxdart/subjects.dart';

class CommentViewModel extends BaseViewModel
    implements CommentViewModelInput, CommentViewModelOutputs{
  final StreamController _contentStreamController =
      StreamController<String>.broadcast();
  final StreamController _movieIdPathStreamController =
      StreamController<String>.broadcast();
  final _dataStreamController = BehaviorSubject<CommentsViewObject>();

  final CommentUseCase _commentUseCase;
  final GetCommentUseCase _getCommentUseCase;

  CommentViewModel(this._commentUseCase, this._getCommentUseCase);
  var movieIdPath = "";
  var content = "";

  @override
  void start() {
    _getComments();
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

  Future<void> _getComments() async{
    inputState.add(LoadingState(
        stateRendererType: StateRendererType.FULL_SCREEN_LOADING_STATE));
    (await _getCommentUseCase.execute(movieIdPath))
        .fold((failure){
          inputState.add(ErrorState(
              StateRendererType.FULL_SCREEN_ERROR_STATE,
              failure.message));
    }, (comments){
          inputState.add(ContentState());
          inputCommentsData.add(CommentsViewObject(comments.comments));
    });
  }

  @override
  // TODO: implement inputComment
  Sink get inputComment => _contentStreamController.sink;

  @override
  // TODO: implement inputMovieIdPath
  Sink get inputMovieIdPath => _movieIdPathStreamController.sink;

  @override
  // TODO: implement inputCommentsData
  Sink get inputCommentsData => _dataStreamController.sink;

  @override
  // TODO: implement outputCommentsData
  Stream<CommentsViewObject> get outputCommentsData => _dataStreamController.stream.map((data) => data);

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
    _dataStreamController.close();
    super.dispose();
  }



}
abstract class CommentViewModelInput{
  comment();
  setCommentContent(String content);
  setMovieIdPath(String movieIdPath);
  Sink get inputComment;
  Sink get inputMovieIdPath;
  Sink get inputCommentsData;
}
abstract class CommentViewModelOutputs{
  Stream<CommentsViewObject> get outputCommentsData;
}
class CommentsViewObject{
  List<Comment> comments;
  CommentsViewObject(this.comments);
}