import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:movie_video/app/app_prefs.dart';
import 'package:movie_video/data/data_source/remote_data_source.dart';
import 'package:movie_video/data/network/app_api.dart';
import 'package:movie_video/data/network/dio_factory.dart';
import 'package:movie_video/data/network/network_info.dart';
import 'package:movie_video/data/repository/repository_Impl.dart';
import 'package:movie_video/domain/repository/repository.dart';
import 'package:movie_video/domain/usecase/forgot_password_usecase.dart';
import 'package:movie_video/domain/usecase/login_usecase.dart';
import 'package:movie_video/domain/usecase/register_usecase.dart';
import 'package:movie_video/presentation/forgot_password/forgot_password_viewmodel.dart';
import 'package:movie_video/presentation/login/login_viewmodel.dart';
import 'package:movie_video/presentation/register/register_viewmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

final instance = GetIt.instance;
Future<void> initAppModule() async{
  final sharedPrefs = await SharedPreferences.getInstance();
  instance.registerLazySingleton<SharedPreferences>(() => sharedPrefs);
  instance.registerLazySingleton<AppPreferences>(() => AppPreferences(instance()));
  instance.registerLazySingleton<NetWorkInfo>(() => NetWorkInfoImpl(InternetConnectionChecker()));
  instance.registerLazySingleton<DioFactory>(() => DioFactory(instance()));
  final dio = await instance<DioFactory>().getDio();
  instance.registerLazySingleton<AppServiceClient>(
          () => AppServiceClient(dio));
  instance.registerLazySingleton<RemoteDataSource>(
          () => RemoteDataSourceImplementer(instance()));
  instance.registerLazySingleton<Repository>(
          () => RepositoryImpl(instance(), instance()));
}
initLoginModule(){
  if(!GetIt.I.isRegistered<LoginUseCase>()){
    instance.registerFactory<LoginUseCase>(() => LoginUseCase(instance()));
    instance.registerFactory<LoginViewModel>(() => LoginViewModel(instance()));
  }
}
initForgotPasswordModule(){
  if(!GetIt.I.isRegistered<ForgotPasswordUseCase>()){
    instance.registerFactory<ForgotPasswordUseCase>(() => ForgotPasswordUseCase(instance()));
    instance.registerFactory<ForgotPasswordViewModel>(() => ForgotPasswordViewModel(instance()));
  }
}
initRegisterModule(){
  if(!GetIt.I.isRegistered<RegisterUseCase>()){
    instance.registerFactory<RegisterUseCase>(() => RegisterUseCase(instance()));
    instance.registerFactory<RegisterViewModel>(() => RegisterViewModel(instance()));
  }
}

resetAllModules(){
  instance.reset(dispose: false);
  initAppModule();
  initRegisterModule();
  initLoginModule();
  initForgotPasswordModule();
}
