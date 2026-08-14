class User {
  final String username;
  final String password;
  final String? name;

  const User({
    required this.username,
    required this.password,
    this.name,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json['username'] as String? ?? '',
      password: json['password'] as String? ?? '',
      name: json['name'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
      if (name != null) 'name': name,
    };
  }
}
