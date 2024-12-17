import 'dart:ffi';

import 'package:movie_video/domain/model/model.dart';
import 'package:movie_video/domain/usecase/recommend_movies_usecase.dart';
import 'package:movie_video/presentation/base/baseviewmodel.dart';
import 'package:rxdart/rxdart.dart';

class RecommendMoviesViewModel extends BaseViewModel
    implements RecommendMoviesModelInputs, RecommendMoviesModelOutputs{
  RecommendMoviesUseCase _recommendMoviesUseCase;
  final _dataStreamController = BehaviorSubject<RecommendMoviesViewObject>();

  RecommendMoviesViewModel(this._recommendMoviesUseCase);
  @override
  void start() {
    // TODO: implement start
  }

  _getRecommendMovies() async{
    (await _recommendMoviesUseCase.execute(Void)).fold((failure){
      print(failure.message);
    }, (movieObject){
      inputRecommendMoviesData.add(RecommendMoviesViewObject(
        movieObject.movies
      ));
    });
  }

  @override
  void dispose() {
    _dataStreamController.close();
    super.dispose();
  }
  @override
  // TODO: implement inputRecommendMoviesData
  Sink get inputRecommendMoviesData => _dataStreamController.sink;

  @override
  // TODO: implement outputRecommendMoviesData
  Stream<RecommendMoviesViewObject> get outputRecommendMoviesData =>
      _dataStreamController.stream.map((data) => data);



}

abstract class RecommendMoviesModelInputs{
  Sink get inputRecommendMoviesData;
}
abstract class RecommendMoviesModelOutputs{
  Stream<RecommendMoviesViewObject> get outputRecommendMoviesData;
}
class RecommendMoviesViewObject{
  List<Movies> movies;
  RecommendMoviesViewObject(this.movies);
}