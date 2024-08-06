import 'package:church_clique/features/auth/models/user_model.dart';

class SignIn {
  final String? username;
  final int? userId;
  

  SignIn({
     this.username,
     this.userId

  });

  factory SignIn.fromJson(Map<String,dynamic> json){
    return SignIn(
      username: json['username'] as String?,
      userId:   json['userId'] as int?  ?? null

    );
  }
  
}


