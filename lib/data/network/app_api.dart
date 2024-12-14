import 'dart:io';

import 'package:dio/dio.dart';
import 'package:movie_video/app/constant.dart';
import 'package:movie_video/data/responses/responses.dart';
import 'package:retrofit/retrofit.dart';
part 'app_api.g.dart';

@RestApi(baseUrl: Constant.baseUrl)
abstract class AppServiceClient{
  factory AppServiceClient(Dio dio, {String baseUrl}) = _AppServiceClient;
  
  @POST("/identity/auth/token")
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

  @POST("/post/comment/{movieId}")
  Future<CommentResponse> comment(
      @Path("movieId") String movieId,
      @Body() Map<String, dynamic> body,
      );

  @POST("/identity/auth/logout")
  Future<BaseResponse> logout(
      @Field("token") String token
      );

  @PUT("/profile/users")
  Future<ProfileResponse> updateProfile(
      @Field("username") String username,
      @Field("firstName") String firstName,
      @Field("lastName") String lastName,
      @Field("avatar") MultipartFile avatar,
      @Field("dob") String dob,
      @Field("city") String city
      );
  
  @GET("/movie/lists")
  Future<PaginatedMoviesResponse> getPaginatedMovies(
      @Query("page") int page,
      @Query("size") int size,
      );

  @GET("/post/comment/{movieId}")
  Future<GetCommentResponse> getComments(
      @Path("movieId") String movieId
      );
  
  @GET("/profile/users")
  Future<ProfileResponse> getProfile();
}