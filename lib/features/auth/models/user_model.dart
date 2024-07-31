class User {
  User({
    required this.username,
    required this.email,
    required this.password,
    required this.id,
    required this.contact,
  });
  

  int id;
  final String username;
  final String email;
  final String password;
  final String contact;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      username: json['username'] as String,
      email: json['email'] as String,
      contact: json['contact'] as String,
      password: json['password'] as String,
    );
  }

  Map<String, dynamic> json() {
    var data = {
      "id": id,
      "username": username,
      "email": email,
      "contact": contact,
      "password": password
    };
    return data;
  }

  User copy({
    int? id,
    String? username,
    String? email,
    String? password,
    String? contact,
  }) {
    return User(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      contact: contact?? this.contact,
      password: password ?? this.password,
    );
  }

  factory User.empty() {
    return User(
      username: 'No Username',
      email: 'No Email',
      password: 'No Password',
      id: 0,
      contact: 'No Contact'
    );
  }
}
