class SliderObject {
  String title;
  String subTitle;
  String image;
  SliderObject(this.title, this.subTitle, this.image);
}
class Authentication{
  String token;
  bool authenticated;
  Authentication(this.token, this.authenticated);
}

class Roles{
  String name;
  String description;
  List<String> permissions;
  Roles(this.name, this.description, this.permissions);
}

class RegisterAuthentication{
  String id;
  String username;
  List<Roles> roles;
  RegisterAuthentication(this.id, this.username, this.roles);
}

class Comment{
  String id;
  String movieId;
  String userId;
  String username;
  String content;
  String created;
  String createdDate;
  String modifiedDate;
  Comment(
      this.id, this.movieId,
      this.userId, this.username,
      this.content, this.created,
      this.createdDate, this.modifiedDate
  );
}

class GetComments{
  List<Comment> comments;
  GetComments(this.comments);
}

class Movies{
  String id;
  String title;
  String category;
  String description;
  String trailerUrl;
  String videoUrl;
  String posterUrl;
  String createdDate;
  String modifiedDate;

  Movies(
      this.id, this.title,
      this.category, this.description,
      this.trailerUrl, this.videoUrl,
      this.posterUrl, this.createdDate,
      this.modifiedDate
      );
}

class PaginatedMovies{
  int currentPage;
  int totalPages;
  int pageSize;
  int totalElements;
  List<Movies> movies;
  PaginatedMovies(
      this.currentPage, this.totalPages,
      this.pageSize, this.totalElements,
      this.movies
      );
}


