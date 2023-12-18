import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../../model/vo/cart_vo/cart_vo.dart';
import '../../model/vo/data_vo/data_vo.dart';

class AddToCartNotifier extends ChangeNotifier {
  Carts _carts = Carts();
  List<Datum> _cartList = [];

  bool _isDispose = false;
  bool _isLoading = true;
  int _quantity = 0;
  String _error = "";

  int get quantity => _quantity;
  Carts get cartListFromSever => _carts;
  List<Datum> get cartDataList => _cartList;
  String get error => _error;
  bool get isLoading => _isLoading;

  void plusCount() {
    ++_quantity;
    notifyListeners();
  }

  void reduceCount() {
    if (_quantity > 0) {
      --_quantity;
    }
    notifyListeners();
  }

//adding item to cart
  addToCart(String productId, String quantity, String token) async {
    const String endpoint = "https://api.ztrademm.com/api/cart/add";
    final url = Uri.parse(endpoint);

    final headers = {
      "Authorization": "Bearer $token",
    };

    try {
      Response response = await http.post(
        url,
        headers: headers,
        body: {"product_id": productId, "quantity": quantity},
      );
      if (response.statusCode == 201) {
        final responseBody = json.decode(response.body);
        print('Successfully Create: ${response.statusCode}');
      } else {
        print(response.statusCode);
      }
    } catch (error) {
      print('Error from adding to cart : $error');
    }
  }

  // cart items from network
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
        print('Data request successfully: ${response.body}');
        _carts = cartsFromJson(response.body);

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

  addQuantityToSever(int cartId, String token) async {
    String endpoint = "https://api.ztrademm.com/api/cart/add-quantity/$cartId";
    final url = Uri.parse(endpoint);

    final headers = {
      "Authorization": "Bearer $token",
    };

    try {
      Response response = await http.post(
        url,
        headers: headers,
      );
      if (response.statusCode == 201) {
        final responseBody = json.decode(response.body);
        print(responseBody["status"]);
        print('Successfully adding quantity : ${response.statusCode}');
      } else {
        print(response.statusCode);
      }
    } catch (error) {
      print('Error from adding to cart : $error');
    }
  }

  reduceQuantityToSever(int cartId, String token) async {
    String endpoint =
        "https://api.ztrademm.com/api/cart/reduce-quantity/$cartId";
    final url = Uri.parse(endpoint);

    final headers = {
      "Authorization": "Bearer $token",
    };

    try {
      Response response = await http.post(
        url,
        headers: headers,
      );
      if (response.statusCode == 201) {
        final responseBody = json.decode(response.body);
        print(responseBody["status"]);
        print('Successfully reduce quantity : ${response.statusCode}');
      } else {
        print(response.statusCode);
      }
    } catch (error) {
      print('Error from adding to cart : $error');
    }
  }

  deleteCartFromSever(int productId, String token) async {
    const String endpoint = "https://api.ztrademm.com/api/cart/remove";
    final url = Uri.parse(endpoint);

    final headers = {
      "Authorization": "Bearer $token",
    };

    try {
      Response response = await http.post(
        url,
        headers: headers,
        body: {"product_id": productId},
      );
      if (response.statusCode == 201) {
        final responseBody = json.decode(response.body);
        print(responseBody);
        print('Successfully delete: ${response.statusCode}');
      } else {
        print(response.statusCode);
      }
    } catch (error) {
      print('Error from adding to cart : $error');
    }
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
