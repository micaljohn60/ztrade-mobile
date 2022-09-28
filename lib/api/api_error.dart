class ApiError{
  String _error;

  ApiError({String error}){
    this._error = error;
  }

  String get error => _error;
  set error(String error)=>_error = error;

  ApiError.fromJson(Map<String,dynamic> json){
    _error = json.toString();
  }
}