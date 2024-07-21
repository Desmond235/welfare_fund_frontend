class User {
  User({
    required this.username,
    required this.email,
    required this.password,
    required this.id,
  });

  int id;
  final String username;
  final String email;
  final String password;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      username: json['username'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
    );
  }

  Map<String, dynamic> json() {
    var data = {
      "id": id,
      "username": username,
      "email": email,
      "password": password
    };
    return data;
  }

  User copy({
    int? id,
    String? username,
    String? email,
    String? password,
  }) {
    return User(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  factory User.empty() {
    return User(
      username: 'No Username',
      email: 'No Email',
      password: 'No Password',
      id: 0,
    );
  }
}
