
class User {
  
  final String username;
  final String password;
  final String token;
  final List<String>? roles;

  User({
    required this.username,
    required this.password,
    required this.token,
    this.roles = const ['USER']
  });

  User copyWith ({
    String? username,
    String? password,
    String? token,
    List<String>? roles
  }) => User(
    username: username ?? this.username,
    password: password ?? this.password,
    token: token ?? this.token,
    roles: roles ?? this.roles
  );

  
}
