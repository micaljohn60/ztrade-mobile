import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:omni_mobile_app/abstract/disposable_provider.dart';

import '../../static/ztradeAPI.dart';

class CategoryWithProduct extends DisposableProvider{
  
  CategoryWithProduct();

  Map<dynamic,dynamic> _map = {};
  List<dynamic> _reverseMap = [];
  bool _error = false;
  String _errorMessage = '';
  String key;
  bool _isSocket = false;
  Map<dynamic,dynamic> get map => _map;
  List<dynamic> get reverseMap => _reverseMap;
  bool get error => _error;
  bool get socket => _isSocket;
  String get errorMessage => _errorMessage;

  Future<void> fetchData(String id,String pageNumber) async {
    Response response;
    try {
      
      ZtradeAPI.environment == "dev" 
      ?
      response = await get(
        Uri.http(ZtradeAPI.localEnvUrl, "/nonrole/product/list/pgtest/"+id+"?page="+pageNumber),
        // headers: {
        //   'Authorization': 'Bearer $token',
        // }
      )
      : 
      response = await get(
        // "https://appstaging.ztrademm.com/nonrole/product/list/pgtest/26?page=1"
        Uri.parse(ZtradeAPI.baseUrl + 'nonrole/product/list/pgtest/'+id+"?page="+pageNumber),
        // headers: {
        //   'Authorization': 'Bearer $token',
        // }
      );


      if (response.statusCode == 200) {
        try {
          _map = jsonDecode(response.body);
          // _reverseMap = _map.reversed.toList();
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
        _errorMessage = 'No Products Found! ';
        _map = {};
        notifyListeners();
      } else {
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
    // TODO: implement disposeValue
  }
}