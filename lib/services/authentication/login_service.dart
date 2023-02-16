import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:omni_mobile_app/api/api_error.dart';
import 'package:omni_mobile_app/api/api_response.dart';
import 'package:omni_mobile_app/model/user.dart';
import 'package:omni_mobile_app/static/ztradeAPI.dart';

Future<ApiResponse> loginUser(String email, String password,) async{
  ApiResponse _apiResponse = ApiResponse();

  try{
    Response response;
    ZtradeAPI.environment == "dev" ?

    response = await post(
        Uri.http(ZtradeAPI.localEnvUrl, "api/login/user"),
        // headers: {
        //   'Authorization': 'Bearer $token',
        // }
        body: {
          'email' : email,
          'password' : password
        }

      )
      :
      response = await post(
        Uri.parse(ZtradeAPI.baseUrl + 'api/login/user'),
        headers: {
          'accept' : 'application/json'
        },
        body: {
          'email' : email,
          'password' : password
        }
      );

      switch(response.statusCode){
        case 201:
        print(response.statusCode);
        _apiResponse.data = User.fromJson(json.decode(response.body));
        break;
        case 404:
         print(response.statusCode);
        _apiResponse.ApiError = json.decode(response.body);
        break;
        case 401:    
        _apiResponse.ApiError = json.decode(response.body);
        break;
        
        default:
         print(response.statusCode);
        _apiResponse.ApiError = json.decode(response.body);
        break;
      }

  }
  on SocketException{
    _apiResponse.ApiError = {"error": "Server error. Please retry"};
  }
  return _apiResponse;
}