import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetWorkInfo{
  Future<bool> get isConnected;
}

class NetWorkInfoImpl implements NetWorkInfo{
  InternetConnectionChecker _dataConnectionChecker;
  NetWorkInfoImpl(this._dataConnectionChecker);
  @override
  // TODO: implement isConnected
  Future<bool> get isConnected => _dataConnectionChecker.hasConnection;

}