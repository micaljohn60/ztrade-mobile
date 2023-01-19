import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:omni_mobile_app/static/ztradeAPI.dart';

class CarouselSliderService with ChangeNotifier {
  CarouselSliderService();

  List<dynamic> _map = [];
  List<dynamic> _reverseMap = [];
  bool _error = false;
  bool _isEmptyData = false;
  String _errorMessage = '';
  String key;
  bool _isSocket = false;
  List<dynamic> get map => _map;
  List<dynamic> get reverseMap => _reverseMap;
  bool get error => _error;
  bool get empty =>_isEmptyData;
  bool get socket => _isSocket;
  String get errorMessage => _errorMessage;

  Future<void> get fetchData async {
    Response response;
    try {
      
      ZtradeAPI.environment == "dev" 
      ?
      response = await get(
        Uri.http(ZtradeAPI.localEnvUrl, "nonrole/slider/list"),
        // headers: {
        //   'Authorization': 'Bearer $token',
        // }
      )
      : 
      response = await get(
        Uri.parse(ZtradeAPI.baseUrl + 'nonrole/category/list'),
        // headers: {
        //   'Authorization': 'Bearer $token',
        // }
      );

      if (response.statusCode == 200) {
        try {
          _map = jsonDecode(response.body);
          _reverseMap = _map.reversed.toList();
          _error = false;
          _isEmptyData = _map.isEmpty ? true : false;
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
        _errorMessage = 'No Active Sliders Found! ';
        _map = [];
        notifyListeners();
      } else {
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
}
