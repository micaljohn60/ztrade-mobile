import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:omni_mobile_app/abstract/disposable_provider.dart';
import 'package:omni_mobile_app/static/ztradeAPI.dart';

class CategoryService extends DisposableProvider {
  CategoryService();

  Map<String, dynamic> _map = {};
  Map<String, dynamic> _reverseMap = {};
  bool _error = false;
  bool _isEmpty = false;
  String _errorMessage = '';
  String key;
  bool _isSocket = false;
  Map<dynamic, dynamic> get map => _map;
  Map<String, dynamic> get reverseMap => _reverseMap;
  bool get error => _error;
  bool get empty => _isEmpty;
  bool get socket => _isSocket;
  String get errorMessage => _errorMessage;

  Future<void> fetchData(String userId) async {
    Response response;
    try {
      ZtradeAPI.environment == "dev"
          ? response = await get(
              Uri.http(ZtradeAPI.localEnvUrl,
                  "nonrole/category/list/user/" + userId),
              // headers: {
              //   'Authorization': 'Bearer $token',
              // }
            )
          : response = await get(
              Uri.parse(
                  ZtradeAPI.baseUrl + "nonrole/category/list/user/" + userId),
              // headers: {
              //   'Authorization': 'Bearer $token',
              // }
            );

      if (response.statusCode == 200) {
        try {
          _map = jsonDecode(response.body);
          _isEmpty = _map.isEmpty ? true : false;
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
        _errorMessage = 'No Item Found! ';
        _map = {};
        notifyListeners();
      } else {
        notifyListeners();
        _error = true;
        _isSocket = false;
        _errorMessage = 'mmm... we have some unstable network issues! ';
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
