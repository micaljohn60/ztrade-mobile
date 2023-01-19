import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:omni_mobile_app/abstract/disposable_provider.dart';
import 'package:omni_mobile_app/api/api_response.dart';

import '../../static/ztradeAPI.dart';

class AboutUsService extends DisposableProvider{
  AboutUsService();

  Map<String,dynamic> _map = {};
  List<dynamic> _reverseMap = [];
  bool _error = false;
  bool _isEmpty = false;
  String _errorMessage = '';
  String key;
  bool _isSocket = false;
  Map<String,dynamic> get map => _map;
  List<dynamic> get reverseMap => _reverseMap;
  bool get isEmpty => _isEmpty;
  bool get error => _error;
  bool get socket => _isSocket;
  String get errorMessage => _errorMessage;

  

  Future<void> get fetchAboutUs async {
    Response response;
    try {
      
      ZtradeAPI.environment == "dev" 
      ?
      response = await get(
        Uri.http(ZtradeAPI.localEnvUrl, "api/aboutus/show/1"),
        // headers: {
        //   'Authorization': 'Bearer $token',
        // }
      )
      : 
      response = await get(
        Uri.parse(ZtradeAPI.baseUrl + "api/aboutus/show/1"),
        // headers: {
        //   'Authorization': 'Bearer $token',
        // }
      );

      if (response.statusCode == 201) {
        try {
          _map = jsonDecode(response.body);
          _isEmpty = _map.isEmpty ? true :false;
          _error = false;
          _isSocket = false;
        } catch (e) {
          _error = true;
          _errorMessage = e.toString();
          _map = {};
          _isSocket = false;
          notifyListeners();
        }
        notifyListeners();
      } else if (response.statusCode == 404) {
        _error = true;
        _isSocket = false;
        _errorMessage = 'Request Fail ';
        _map = {};
        notifyListeners();
      } 
      else if(response.statusCode == 403){
        notifyListeners();
        _error = true;
        _isSocket = false;
        _errorMessage = 'Permission Denied';
        _map = {};
      }
      else {
        print(response.statusCode);
        notifyListeners();
        _error = true;
        _isSocket = false;
        _errorMessage = 'Not Found! ';
        _map = {};
      }
    } on SocketException catch (e) {
      _error = true;
      _isSocket = true;
      _errorMessage = "Connection Failure";
      _map = {};
      notifyListeners();
    }
  }

  @override
  void disposeValue() {
    _map = {};
  }
}