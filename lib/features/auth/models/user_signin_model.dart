class SignIn {
  final String? username;
  final bool rememberMe;

  SignIn({
    required this.username,
    required this.rememberMe,
  });

  factory SignIn.fromJson(Map<String,dynamic> json){
    return SignIn(
      username: json['username'] as String?,
      rememberMe: json['rememberMe'] as bool,
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'username': username,
     'rememberMe': rememberMe,
    };
  }
}
