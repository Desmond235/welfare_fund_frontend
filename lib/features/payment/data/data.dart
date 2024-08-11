
import 'package:flutter/material.dart';

class AuthorizationUrl extends ChangeNotifier{
   String _authorization_url = '';
 String get authorization_url => _authorization_url;

  void authUrl(String url){
    _authorization_url = url;
    notifyListeners();
  }
}