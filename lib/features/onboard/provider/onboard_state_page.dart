
import 'package:flutter/material.dart';

class OnboardStatePage extends ChangeNotifier{
  int _totalPages = 3;
  int _currentPage = 0;
  int get currentPage => _currentPage;

  void setCurrentPage(int value){ 
    if(value < 0){
      _currentPage = 0;
    }else if (value > _totalPages){
      _currentPage = _totalPages;
    }else{
      _currentPage = value;
    }
    notifyListeners();
  }

  void incrementPage(){
    if(_currentPage < _totalPages){
      _currentPage++;
    }
    notifyListeners();
  }

  void  decrementPage(){
    if (_currentPage > 0){ 
      _currentPage--;
    }
    notifyListeners();
  }
}