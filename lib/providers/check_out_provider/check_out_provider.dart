import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:omni_mobile_app/model/vo/data_vo/data_vo.dart';
import '../../model/vo/cart_vo/cart_vo.dart';

class CheckOutProvider extends ChangeNotifier {
  bool _isDispose = false;
  bool _isLoading = true;
  String _error = "";
  List<Datum> _cartList = [];

  get isLoading => _isLoading;
  get error => _error;
  List<Datum> get cartList => _cartList;

  getCartsFromAPI(String token) async {
    const String url = "http://api.ztrademm.com/api/cart";
    try {
      Response response = await http.get(
        Uri.parse(url),
        headers: {
          "Authorization": "Bearer $token",
        },
      );

      if (response.statusCode == 201) {
        print('Data fetched successfully: ${response.body}');

        _cartList = cartsFromJson(response.body).data;
        print(_cartList);
      } else {
        _error = response.statusCode.toString();
      }
    } catch (error) {
      _error = "This error is calling data from network :${error.toString()}";
    }
    _isLoading = false;
    notifyListeners();
  }

  @override
  void notifyListeners() {
    if (!_isDispose) {
      super.notifyListeners();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _isDispose = true;
  }
}
