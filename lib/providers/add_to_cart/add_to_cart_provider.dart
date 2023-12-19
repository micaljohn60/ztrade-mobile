import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import '../../model/vo/cart_vo/cart_vo.dart';
import '../../model/vo/data_vo/data_vo.dart';

class AddToCartNotifier extends ChangeNotifier {
  List<Datum> _cartList = [];
  String isSuccessToAdd = "";
  String isSuccessDelete = "";
  String _cartDataReqSuccess = "";
  bool _isDispose = false;
  bool _isLoading = true;
  int _quantity = 0;
  String _error = "";
  int cartLength = 0;

  int get quantity => _quantity;
  List<Datum> get cartDataList => _cartList.toList();
  String get error => _error;
  bool get isLoading => _isLoading;
  String get severLoad => isSuccessToAdd;
  String get delete => isSuccessDelete;

  String get cartDataReqSuccess => _cartDataReqSuccess;
  void plusCount() {
    _quantity++;
    notifyListeners();
  }

  // set reqSuccess(String str) {
  //   _cartDataReqSuccess = str;
  //   notifyListeners();
  // }
  //
  // set successToAdd(String str) {
  //   isSuccessToAdd = str;
  //   notifyListeners();
  // }
  //
  // set successToDelete(String str) {
  //   isSuccessDelete = str;
  //   notifyListeners();
  // }

  void removeCart(int index) {
    _cartList.removeAt(index);
    notifyListeners();
  }

  void reduceCount() {
    if (_quantity > 0) {
      _quantity--;
    }
    notifyListeners();
  }

//adding item to cart
  addToCart(int productId, int quantity, String token) async {
    const String endpoint = "https://api.ztrademm.com/api/cart/add";
    final url = Uri.parse(endpoint);

    final headers = {
      "Authorization": "Bearer $token",
    };

    try {
      Response response = await http.post(
        url,
        headers: headers,
        body: {
          "product_id": productId.toString(),
          "quantity": quantity.toString()
        },
      );
      if (response.statusCode == 201) {
        final responseBody = json.decode(response.body);
        isSuccessToAdd = responseBody["status"];

        print(" success add $isSuccessToAdd");

        print('Successfully Create New Cart Item: ${response.statusCode}');
      } else {
        print("fail adding to cart : ${response.statusCode}");
      }
    } catch (error) {
      print('Error from adding to cart : $error');
    }
    notifyListeners();
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
        _cartList = cartsFromJson(response.body).data;
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

        print('Successfully adding quantity : ${response.statusCode}');
      } else {
        print(response.statusCode);
      }
    } catch (error) {
      print('Error from adding to cart : $error');
    }
    notifyListeners();
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
    notifyListeners();
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
        isSuccessDelete = responseBody["status"];
      } else {
        print(response.statusCode);
      }
    } catch (error) {
      print('Error from adding to cart : $error');
    }
    notifyListeners();
  }
}
