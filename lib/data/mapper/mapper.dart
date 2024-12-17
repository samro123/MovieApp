import 'package:movie_video/app/extensions.dart';
import 'package:movie_video/data/responses/responses.dart';
import 'package:movie_video/domain/model/model.dart';

const EMPTY = "";
const ZERO = 0;
extension AuthenticationResponseMapper on AuthenticationResponse?{
  Authentication toDomain(){
    return Authentication(
        this?.result?.token?.orEmpty() ?? EMPTY,
        this?.result?.expiryTime.orEmpty() ?? EMPTY
    );
  }
}
extension ForgotPasswordResponseMapper on ForgotPasswordResponse?{
  String toDomain(){
    return this?.support?.orEmpty() ?? EMPTY;
  }
}
extension RolesResponseMapper on RoleResponse?{
  Roles toDomain(){
    return Roles(
        this?.name?.orEmpty() ?? EMPTY,
        this?.description?.orEmpty() ?? EMPTY,
        (this?.permissions?.map((permissions) => permissions) ?? Iterable.empty()).cast<String>().toList()
    );
  }
}
extension RegisterAuthenticationResponseMapper on RegisterAuthResponse?{
  RegisterAuthentication toDomain(){
    List<Roles> mapRoles = (this?.result?.roles?.map((roles) => roles.toDomain())
        ?? Iterable.empty()).cast<Roles>().toList();
    return RegisterAuthentication(
        this?.result?.id?.orEmpty() ?? EMPTY,
        this?.result?.username?.orEmpty() ?? EMPTY,
        mapRoles);
  }
}
extension MovieResponseMapper on MovieResponse?{
  Movies toDomain(){
    return Movies(
        this?.id?.orEmpty() ?? EMPTY,
        this?.title?.orEmpty() ?? EMPTY,
        this?.category?.orEmpty() ?? EMPTY,
        this?.description?.orEmpty() ?? EMPTY,
        this?.trailerUrl?.orEmpty() ?? EMPTY,
        this?.videoUrl?.orEmpty() ?? EMPTY,
        this?.posterUrl?.orEmpty() ?? EMPTY,
        this?.createdDate?.orEmpty() ?? EMPTY,
        this?.modifiedDate?.orEmpty() ?? EMPTY,
    );
  }
}
extension PaginatedMoviesResponseMapper on PaginatedMoviesResponse?{
  PaginatedMovies toDomain(){
    List<Movies> mapMovies = (this?.result?.data?.map((movies) => movies.toDomain())
        ?? Iterable.empty()).cast<Movies>().toList();
    return PaginatedMovies(
        this?.result?.currentPage?.orZero() ?? ZERO,
        this?.result?.totalPages?.orZero() ?? ZERO,
        this?.result?.pageSize?.orZero() ?? ZERO,
        this?.result?.totalElements?.orZero() ?? ZERO,
        mapMovies
    );
  }
}
extension RecommendMoviesResponseMapper on RecommendMoviesResponse?{
  RecommendMovies toDomain(){
    List<Movies> mappedMovies = (this?.result?.map((moviesResponse) => moviesResponse.toDomain())
        ?? Iterable.empty()).cast<Movies>().toList();
    return RecommendMovies(mappedMovies);
  }
}
extension CommentResponseMapper on CommentResponse?{
  Comment toDomain(){
    return Comment(
        this?.result?.id?.orEmpty() ?? EMPTY,
        this?.result?.movieId?.orEmpty() ?? EMPTY,
        this?.result?.userId?.orEmpty() ?? EMPTY,
        this?.result?.username?.orEmpty() ?? EMPTY,
        this?.result?.content?.orEmpty() ?? EMPTY,
        this?.result?.avatar?.orEmpty() ?? EMPTY,
        this?.result?.created?.orEmpty() ?? EMPTY,
        this?.result?.createdDate?.orEmpty() ?? EMPTY,
        this?.result?.modifiedDate?.orEmpty() ?? EMPTY,);
  }
}
extension CommentResultMapper on CommentResult? {
  Comment toDomain() {
    return Comment(
      this?.id?.orEmpty() ?? EMPTY,
      this?.movieId?.orEmpty() ?? EMPTY,
      this?.userId?.orEmpty() ?? EMPTY,
      this?.username?.orEmpty() ?? EMPTY,
      this?.content?.orEmpty() ?? EMPTY,
      this?.avatar?.orEmpty() ?? EMPTY,
      this?.created?.orEmpty() ?? EMPTY,
      this?.createdDate?.orEmpty() ?? EMPTY,
      this?.modifiedDate?.orEmpty() ?? EMPTY,
    );
  }
}
extension GetCommentResponseMapper on GetCommentResponse?{
  GetComments toDomain(){
    List<Comment> mappedComments = (this?.result?.map((commentResponse) => commentResponse.toDomain())
        ?? Iterable.empty()).cast<Comment>().toList();
    return GetComments(mappedComments);
  }
}
extension ProfileResponseMapper on ProfileResponse?{
  Profile toDomain(){
    return Profile(
        this?.result?.username?.orEmpty() ?? EMPTY,
        this?.result?.firstName?.orEmpty() ?? EMPTY,
        this?.result?.lastName?.orEmpty() ?? EMPTY,
        this?.result?.avatar?.orEmpty() ?? EMPTY,
        this?.result?.dob?.orEmpty() ?? EMPTY,
        this?.result?.city?.orEmpty() ?? EMPTY);
  }
}