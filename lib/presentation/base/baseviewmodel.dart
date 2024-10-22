import 'dart:async';

import 'package:movie_video/presentation/common/state_renderer/state_renderer_impl.dart';

abstract class BaseViewModel implements
    BaseViewModelInputs, BaseViewModelOutputs {
  StreamController _inputStateStreamController =
      StreamController<FlowState>.broadcast();
  @override
  Sink get inputState => _inputStateStreamController.sink;
  @override
  Stream<FlowState> get outputState =>
      _inputStateStreamController.stream.map((flowState) => flowState);
  @override
  void dispose() {
    _inputStateStreamController.close();
  }
}

abstract class BaseViewModelInputs {
  void start();
  void dispose();

  Sink get inputState;
}

abstract class BaseViewModelOutputs {
  Stream<FlowState> get outputState;
}
