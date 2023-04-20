import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:omni_mobile_app/abstract/disposable_provider.dart';
import 'package:omni_mobile_app/api/api_error.dart';
import 'package:omni_mobile_app/api/api_response.dart';
import 'package:omni_mobile_app/model/user.dart';
import 'package:omni_mobile_app/services/secure_storage/custom_secure_storage.dart';
import 'package:omni_mobile_app/static/ztradeAPI.dart';


class UserService extends DisposableProvider{
  UserService();

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

  Future<void> fetchData(String id) async {
    CustomSecureStorage css = CustomSecureStorage();
    
    Response response;
    try {
      
      ZtradeAPI.environment == "dev" 
      ?
      response = await get(
        Uri.http(ZtradeAPI.localEnvUrl, "api/user/show/"+id),
        // headers: {
        //   'Authorization': 'Bearer $token',
        // }
      )
      : 
      response = await get(
        Uri.parse(ZtradeAPI.baseUrl + 'api/user/show/'+id),
        // headers: {
        //   'Authorization': 'Bearer $token',
        // }
      );

      if (response.statusCode == 200) {
        try {
          _map = jsonDecode(response.body);
          
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
        _errorMessage = 'Error 404! ';
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
        notifyListeners();
        print(response.statusCode);
        _error = true;
        _isSocket = false;
        print(id);
        _errorMessage = 'Unstable Connection ';
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


Future<ApiResponse> updateUser(String name, String factoryName,String id,String profilePicture) async{
  ApiResponse _apiResponse = ApiResponse();
  String _baseUrl=ZtradeAPI.baseUrl + "api/user/update/"+id;
   Map<String, String> headers = {
      'Content-Type': 'multipart/form-data',
    };
  print(name);
  print(factoryName);
  try{
    var url = Uri.parse(_baseUrl);
    var req = http.MultipartRequest(
      'post',url,  
    )..headers.addAll(headers);
    req.fields['name'] = name;
    req.fields['factory_name'] = factoryName;
    if(profilePicture == '-' || profilePicture == null){
     
      req.fields['profile_pic'] = "null"; 
    }
    else{
      print(profilePicture);
      req.files.add(
    await http.MultipartFile.fromPath(
      'profile_pic',
      profilePicture
    ));
    }

    var response = await req.send();

    // Response response;
    // ZtradeAPI.environment == "dev" ?

    // response = await post(
    //     Uri.http(ZtradeAPI.localEnvUrl, "api/user/update/"+id),
    //     // headers: {
    //     //   'Authorization': 'Bearer $token',
    //     // }
    //     body: {
    //       'name' : name,
    //       'factory_name' : factoryName
    //     }

    //   )
    //   :
    //   response = await post(
    //     Uri.parse(ZtradeAPI.baseUrl + 'api/user/update/'+id),
    //     // headers: {
    //     //   'Authorization': 'Bearer $token',
    //     // }
    //     body: {
    //       'name' : name,
    //       'factory_name' : factoryName
    //     }
    //   );

      switch(response.statusCode){
        case 201:
        print(response.statusCode);
        print(json.decode(await response.stream.bytesToString()));
        // _apiResponse.data = User.fromJson(json.decode(await response.stream.bytesToString()));
        break;
        case 404:
         print(response.statusCode);
        _apiResponse.ApiError = json.decode(await response.stream.bytesToString());
        break;
        case 401:    
        _apiResponse.ApiError = json.decode(await response.stream.bytesToString());
        break;
        
        default:
         print(response.statusCode);
         print(json.decode(json.encode(await response.stream.bytesToString())));
        //_apiResponse.ApiError = json.decode(await response.stream.bytesToString());
        break;
      }

  }
  on SocketException{
    _apiResponse.ApiError = {"error": "Server error. Please retry"};
  }
  return _apiResponse;
}