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