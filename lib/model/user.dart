import 'package:flutter/material.dart';
import 'package:http/http.dart';


class User with ChangeNotifier{
  String _userId;
  String _userName;
  String _email;
  String _token;
  String key;
  String message;
  String id;
  List<dynamic> _map = [];
  bool _error = false;
  
  String _errorMessage;
  

  User();

  List<dynamic> get map => _map;
  bool get error => _error;
  

  String get userId => _userId;
  set userId(String userId) => _userId = userId;
  
  String get username => _userName;
  set username(String username) => _userName = username;

   String get errorMessages => _errorMessage;
  set errorMessage(String username) => _errorMessage = username;

  String get email => _email;
  set email(String email) => _email = email;

  String get token => _token;
  set token(String token) => _token = token; 

  User.fromJson(Map<String, dynamic> json) {
    _token = json['token'];
    _userId = json["user"]["id"].toString();
    _email = json["user"]["email"];
    _userName = json["user"]["name"];
    
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    return data;
  }
}