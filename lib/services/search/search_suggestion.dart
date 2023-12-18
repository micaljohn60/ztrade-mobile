import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:omni_mobile_app/abstract/disposable_provider.dart';
import 'package:omni_mobile_app/api/api_response.dart';

import '../../static/ztradeAPI.dart';

class SearchSuggestionService extends DisposableProvider {
  SearchSuggestionService();

  Map<dynamic, dynamic> _map = {};
  List<String> _stringData = [];
  List<dynamic> _reverseMap = [];
  bool _error = false;
  String _errorMessage = '';
  String key;
  bool _isSocket = false;
  Map<dynamic, dynamic> get map => _map;
  List<dynamic> get reverseMap => _reverseMap;
  List<String> get stringData => _stringData;
  bool get error => _error;
  bool get socket => _isSocket;
  String get errorMessage => _errorMessage;

  Future<void> fetchData(String data) async {
    Response response;
    try {
      ZtradeAPI.environment == "dev"
          ? response = await get(
              Uri.http(ZtradeAPI.localEnvUrl,
                  "nonrole/search/suggestions/user/" + data),
              // headers: {
              //   'Authorization': 'Bearer $token',
              // }
            )
          : response = await get(
              Uri.parse(ZtradeAPI.baseUrl +
                  "nonrole/search/suggestions/user/" +
                  data),
              // headers: {
              //   'Authorization': 'Bearer $token',
              // }
            );

      if (response.statusCode == 200) {
        try {
          _map = jsonDecode(response.body);
          List<String> c = List<String>.from(_map['productSuggestion'] as List);
          _stringData = c;
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
        _errorMessage = 'No Product Found! ';
        _map = {};
        notifyListeners();
      } else if (response.statusCode == 403) {
        notifyListeners();
        _error = true;
        _isSocket = false;
        _errorMessage = 'Permission Denied';
        _map = {};
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
  }
}

Future<ApiResponse> addSearchSuggestion(String id, String data) async {
  ApiResponse _apiResponse = ApiResponse();

  try {
    Response response;
    ZtradeAPI.environment == "dev"
        ? response = await post(
            Uri.http(ZtradeAPI.localEnvUrl,
                "nonrole/searchsuggestion/usersearch/" + id + "/" + data),
            // headers: {
            //   'Authorization': 'Bearer $token',
            // }
            body: {
                'user_id': id,
                'search_data': data,
              })
        : response = await post(
            Uri.parse(ZtradeAPI.baseUrl + 'nonrole/search/addsearchlist'),
            headers: {
                'accept': 'application/json'
              },
            body: {
                'user_id': id,
                'search_data': data,
              });

    switch (response.statusCode) {
      case 200:
        // print("hello");
        break;
      case 404:
        // print("not fount");
        break;

      default:
        // print(response.statusCode);
        // print(response.body);
        _apiResponse.ApiError = json.decode(response.body);
        break;
    }
  } on SocketException {
    _apiResponse.ApiError = {"error": "Server error. Please retry"};
  }
  return _apiResponse;
}
