class ApiResponse{

  Object _data;

  Object _apiError;

  Object get data => _data;
  set data(Object data)=> _data = data;

  Object get apiError => _apiError;
  set apiError(Object apiError) => _apiError = apiError;

}