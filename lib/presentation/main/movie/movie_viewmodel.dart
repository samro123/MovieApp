import 'package:movie_video/domain/model/model.dart';
import 'package:movie_video/domain/usecase/paginated_movies_usecase.dart';
import 'package:movie_video/presentation/base/baseviewmodel.dart';
import 'package:movie_video/presentation/common/state_renderer/state_renderer.dart';
import 'package:movie_video/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:rxdart/rxdart.dart';

class PaginatedMoviesViewModel extends BaseViewModel
  implements PaginatedViewModelInputs, PaginatedViewModelOutputs{
  PaginatedMoviesUseCase _paginatedMoviesUseCase;

  final _dataStreamController = BehaviorSubject<PaginatedMoviesViewObject>();
  final _pageStreamController = BehaviorSubject<int>();
  final _sizeStreamController = BehaviorSubject<int>();

  PaginatedMoviesViewModel(this._paginatedMoviesUseCase){
    Rx.combineLatest2<int, int, void>(
      _pageStreamController.stream,
      _sizeStreamController.stream,
        (page, size) => getPaginatedMovies(page, size),
    ).listen((event) { });
  }

  @override
  void start() {
    _pageStreamController.sink.add(1);
    _sizeStreamController.sink.add(10);
  }

  Future<void> getPaginatedMovies(int page, int size) async{
    inputState.add(LoadingState(
        stateRendererType: StateRendererType.FULL_SCREEN_LOADING_STATE));
    (await _paginatedMoviesUseCase.execute(
        PaginatedMoviesParams(page, size)))
        .fold((failure){
          inputState.add(ErrorState(
              StateRendererType.FULL_SCREEN_ERROR_STATE, failure.message));
    }, (paginatedMovies){
          inputState.add(ContentState());
          inputPaginatedMoviesData.add(PaginatedMoviesViewObject(paginatedMovies.movies));
    });
  }

  @override
  // TODO: implement inputPage
  Sink<int> get inputPage => _pageStreamController.sink;

  @override
  // TODO: implement inputSize
  Sink<int> get inputSize => _sizeStreamController.sink;

  @override
  // TODO: implement inputPaginatedMoviesData
  Sink get inputPaginatedMoviesData => _dataStreamController.sink;
  @override
  // TODO: implement outputPaginatedMoviesData
  Stream<PaginatedMoviesViewObject> get outputPaginatedMoviesData => _dataStreamController.stream.map((data) => data);

  @override
  void dispose() {
    _dataStreamController.close();
    _sizeStreamController.close();
    _pageStreamController.close();
    super.dispose();
  }
}

abstract class PaginatedViewModelInputs{
  Sink<int> get inputPage;
  Sink<int> get inputSize;
  Sink get inputPaginatedMoviesData;
}
abstract class PaginatedViewModelOutputs{
  Stream<PaginatedMoviesViewObject> get outputPaginatedMoviesData;
}

class PaginatedMoviesViewObject{
  List<Movies> paginatedMove;
  PaginatedMoviesViewObject(this.paginatedMove);
}