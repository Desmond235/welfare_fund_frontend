
import 'package:flutter/material.dart';

class AuthorizationUrl extends ChangeNotifier{
   String _authorization_url = '';
   String _reference = '';
 String get authorization_url => _authorization_url;
 String get reference => _reference;

  void authUrl(String url){
    _authorization_url = url;
    notifyListeners();
  }

  void setReference(String ref){
    _reference = ref;
    notifyListeners();
  }
}