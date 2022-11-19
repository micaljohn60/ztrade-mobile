import 'package:omni_mobile_app/api/api_error.dart';

class ApiResponse{

  Object _data;

  Object _apiError;

  Object get data => _data;
  set data(Object data)=> _data = data;

  Object get apiError => _apiError;
  set ApiError(Map<dynamic,dynamic> apiError) => _apiError = apiError;

}