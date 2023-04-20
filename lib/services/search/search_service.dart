import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:omni_mobile_app/abstract/disposable_provider.dart';

import '../../static/ztradeAPI.dart';

class SearchService extends DisposableProvider{
  SearchService();

  List<dynamic> _map = [];
  List<dynamic> _reverseMap = [];
  bool _error = false;
  bool _isDataEmpty = false;
  bool _isLoading = true;
  String _errorMessage = '';
  String key;
  bool _isSocket = false;
  List<dynamic> get map => _map;
  List<dynamic> get reverseMap => _reverseMap;
  bool get error => _error;
  bool get isLoading => _isLoading;
  bool get isDataEmpty => _isDataEmpty;
  bool get socket => _isSocket;
  String get errorMessage => _errorMessage;

  Future<void> fetchData(String data) async {
    Response response;
    try {
      
      ZtradeAPI.environment == "dev" 
      ?
      response = await get(
        Uri.http(ZtradeAPI.localEnvUrl, "api/search/"+data+"/null"),
        // headers: {
        //   'Authorization': 'Bearer $token',
        // }
      )
      : 
      response = await get(
        Uri.parse(ZtradeAPI.baseUrl + "api/search/"+data+"/null"),
        // headers: {
        //   'Authorization': 'Bearer $token',
        // }
      );

      if (response.statusCode == 200) {
        try {
          _map = jsonDecode(response.body);
          _isDataEmpty = _map.length == 0 ? true : false;
          _error = false;
          _isLoading = false;
          _isSocket = false;
        } catch (e) {
          _error = true;
          _errorMessage = e.toString();
          _map = [];
          _isSocket = false;
          notifyListeners();
        }
        notifyListeners();
      } else if (response.statusCode == 404) {
        _error = true;
        _isSocket = false;
        _errorMessage = 'No Product Found! ';
        _map = [];
        notifyListeners();
      } 
      else if(response.statusCode == 403){
        notifyListeners();
        _error = true;
        _isSocket = false;
        _errorMessage = 'Permission Denied';
        _map = [];
      }
      else {
        notifyListeners();
        _error = true;
        _isSocket = false;
        _errorMessage = 'Not Found! ';
        _map = [];
      }
    } on SocketException catch (e) {
      _error = true;
      _isSocket = true;
      _errorMessage = "Connection Failure";
      _map = [];
      notifyListeners();
    }
  }

  @override
  void disposeValue() {
    _map = [];
    _isDataEmpty = false;
    _isLoading = true;
  }
}