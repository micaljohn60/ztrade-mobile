import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:omni_mobile_app/api/api_error.dart';
import 'package:omni_mobile_app/api/api_response.dart';
import 'package:omni_mobile_app/model/user.dart';
import 'package:omni_mobile_app/static/ztradeAPI.dart';

Future<ApiResponse> registerUser(String userName, String email, String factoryName,String password) async{
  ApiResponse _apiResponse = ApiResponse();

  try{
    Response response;
    ZtradeAPI.environment == "dev" ?

    response = await post(
        Uri.http(ZtradeAPI.localEnvUrl, "nonrole/user/register"),
        // headers: {
        //   'Authorization': 'Bearer $token',
        // }
        body: {
          'name' : userName,
          'email' : email,
          'factory' : factoryName,
          'password' : password
        }

      )
      :
      response = await post(
        Uri.parse(ZtradeAPI.baseUrl + 'nonrole/user/register'),
        headers: {
          'accept' : 'application/json'
        },
        body: {
          'name' : userName,
          'email' : email,
          'factory' : factoryName,
          'password' : password
        }
      );
      
      switch(response.statusCode){
        
        case 201:
       
        _apiResponse.data = User.fromJson(json.decode(response.body));
        break;
        case 404:
         
        _apiResponse.data = User.fromJson(json.decode(response.body));
        break;
        
        default:
        print(response.statusCode);
        print(response.body);
        _apiResponse.ApiError = json.decode(response.body);
        break;
      }

  }
  on SocketException{
    _apiResponse.ApiError = {"error": "Server error. Please retry"};
  }
  return _apiResponse;
}