import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:omni_mobile_app/api/api_error.dart';
import 'package:omni_mobile_app/api/api_response.dart';
import 'package:omni_mobile_app/model/user.dart';
import 'package:omni_mobile_app/static/ztradeAPI.dart';

 

Future<ApiResponse> addToFavourite(String userId, String productId) async{
  ApiResponse _apiResponse = ApiResponse();

  try{
    Response response;
    ZtradeAPI.environment == "dev" ?

    response = await post(
        Uri.http(ZtradeAPI.localEnvUrl, "api/wishlist/"+userId+"/"+productId),
        // headers: {
        //   'Authorization': 'Bearer $token',
        // }
        // body: {
        //   'name' : userName,
        //   'email' : email,
        //   'factoryName' : factoryName,
        //   'password' : password
        // }

      )
      :
      response = await post(
        Uri.parse(ZtradeAPI.baseUrl + "api/wishlist/"+userId+"/"+productId),
        // headers: {
        //   'Authorization': 'Bearer $token',
        // }
        // body: {
        //   'name' : userName,
        //   'email' : email,
        //   'factoryName' : factoryName,
        //   'password' : password
        // }
      );

      switch(response.statusCode){
        case 201:
       
        _apiResponse.data = json.decode(response.body);
        break;
        case 404:
         
        _apiResponse.data = json.decode(response.body);
        break;
        
        default:
        
        _apiResponse.ApiError = json.decode(response.body);
        break;
      }

  }
  on SocketException{
    _apiResponse.ApiError = {"error": "Server error. Please retry"};
  }
  return _apiResponse;
}

Future<ApiResponse> removeFromFavourite(String userId, String productId) async{
  ApiResponse _apiResponse = ApiResponse();

  try{
    Response response;
    ZtradeAPI.environment == "dev" ?

    response = await delete(
        Uri.http(ZtradeAPI.localEnvUrl, "api/wishlist/remove/"+userId+"/"+productId),
        // headers: {
        //   'Authorization': 'Bearer $token',
        // }
        // body: {
        //   'name' : userName,
        //   'email' : email,
        //   'factoryName' : factoryName,
        //   'password' : password
        // }

      )
      :
      response = await delete(
        Uri.parse(ZtradeAPI.baseUrl + "api/wishlist/remove/"+userId+"/"+productId),
        // headers: {
        //   'Authorization': 'Bearer $token',
        // }
        // body: {
        //   'name' : userName,
        //   'email' : email,
        //   'factoryName' : factoryName,
        //   'password' : password
        // }
      );

      switch(response.statusCode){
        case 201:
       
        _apiResponse.data = json.decode(response.body);
        break;
        case 404:
         
        _apiResponse.data = json.decode(response.body);
        break;
        
        default:
        
        _apiResponse.ApiError = json.decode(response.body);
        break;
      }

  }
  on SocketException{
    _apiResponse.ApiError = {"error": "Server error. Please retry"};
  }
  return _apiResponse;
}