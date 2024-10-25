import 'package:dio/dio.dart';
import 'package:movie_video/app/constant.dart';
import 'package:movie_video/data/responses/responses.dart';
import 'package:retrofit/retrofit.dart';
part 'app_api.g.dart';

@RestApi(baseUrl: Constant.baseUrl)
abstract class AppServiceClient{
  factory AppServiceClient(Dio dio, {String baseUrl}) = _AppServiceClient;
  
  @POST("/customer/login")
  Future<AuthenticationResponse> login(
      @Field("username") String username,
      @Field("password") String password);
  
  @POST("/customer/forgotPassword")
  Future<ForgotPasswordResponse> forgotPassword(@Field("email") String email);
  
  @POST("/identity/users")
  Future<RegisterAuthResponse> register(
      @Field("username") String username,
      @Field("password") String password,
      @Field("firstName") String firstName,
      @Field("lastName") String lastName,
      @Field("dob") String dob
      );
}