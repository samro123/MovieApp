import 'package:movie_video/data/network/app_api.dart';
import 'package:movie_video/data/request/request.dart';
import 'package:movie_video/data/responses/responses.dart';

abstract class RemoteDataSource{
  Future<AuthenticationResponse> login(LoginRequest loginRequest);
  Future<ForgotPasswordResponse> forgotPassword(String email);
  Future<RegisterAuthResponse> register(RegisterRequest registerRequest);
  Future<PaginatedMoviesResponse> getPaginatedMovie(int page, int size);
  Future<CommentResponse> comment(String movieId, String comment);
  Future<GetCommentResponse> getComment(String movieId);
  Future<BaseResponse> logout(String token);
  Future<ProfileResponse> updateProfile(ProfileRequest profileRequest);
  Future<ProfileResponse> getProfile();
}
class RemoteDataSourceImplementer implements RemoteDataSource{
  AppServiceClient _appServiceClient;
  RemoteDataSourceImplementer(this._appServiceClient);

  @override
  Future<AuthenticationResponse> login(LoginRequest loginRequest) async{
    return await _appServiceClient.login(
        loginRequest.username,
        loginRequest.password
    );
  }

  @override
  Future<ForgotPasswordResponse> forgotPassword(String email) async{
    return await _appServiceClient.forgotPassword(email);
  }

  @override
  Future<RegisterAuthResponse> register(RegisterRequest registerRequest) async{
    return await _appServiceClient.register(
        registerRequest.username,
        registerRequest.password,
        registerRequest.firstName,
        registerRequest.lastName,
        registerRequest.dob
    );
  }

  @override
  Future<PaginatedMoviesResponse> getPaginatedMovie(int page, int size) async{
    return await _appServiceClient.getPaginatedMovies(page, size);
  }

  @override
  Future<CommentResponse> comment(String movieId, String comment) async {
    return await _appServiceClient.comment(movieId, {"content":comment});
  }

  @override
  Future<GetCommentResponse> getComment(String movieId) async{
    return await _appServiceClient.getComments(movieId);
  }

  @override
  Future<BaseResponse> logout(String token) async{
    return await _appServiceClient.logout(token);
  }

  @override
  Future<ProfileResponse> updateProfile(ProfileRequest profileRequest) async{
    return await _appServiceClient.updateProfile(
        profileRequest.username,
        profileRequest.firstName,
        profileRequest.lastName,
        profileRequest.avatar,
        profileRequest.dob,
        profileRequest.city);
  }

  @override
  Future<ProfileResponse> getProfile() async{
    return await _appServiceClient.getProfile();
  }
}