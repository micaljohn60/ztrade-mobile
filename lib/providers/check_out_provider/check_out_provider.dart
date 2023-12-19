import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:omni_mobile_app/model/vo/data_vo/data_vo.dart';

import '../../model/vo/address_vo/address.dart';

class CheckOutProvider extends ChangeNotifier {
  int totalAmount = 0;
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _postalCodeController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  TextEditingController get streetController => _streetController;
  TextEditingController get cityController => _cityController;
  TextEditingController get stateController => _stateController;
  TextEditingController get countryController => _countryController;
  TextEditingController get postalCodeController => _postalCodeController;
  TextEditingController get phoneController => _phoneController;
  bool _isDispose = false;
  bool _isLoading = true;
  String _orderCheckOut = '';
  String _error = "";
  Address _address = Address();
  get isLoading => _isLoading;
  get error => _error;
  Address get address => _address;
  String get orderCheckOutSuccess => _orderCheckOut;

  //adding item to cart
  addAddress(String token) async {
    const String endpoint = "http://api.ztrademm.com/api/address";
    final url = Uri.parse(endpoint);

    final headers = {
      "Authorization": "Bearer $token",
    };

    try {
      Response response = await http.post(
        url,
        headers: headers,
        body: {
          "street": streetController.text,
          "city": cityController.text,
          "state": stateController.text,
          "country": countryController.text,
          "postal_code": postalCodeController.text,
          "phone": phoneController.text,
        },
      );
      print(streetController.text);
      print(cityController.text);
      print(stateController.text);
      print(countryController.text);
      print(postalCodeController.text);
      print(phoneController.text);
      if (response.statusCode == 201) {
      } else {
        print("fail adding to cart : ${response.statusCode}");
      }
    } catch (error) {
      print('Error from adding to cart : $error');
    }
    notifyListeners();
  }

  //address from network
  getAddress(String token) async {
    const String url = "http://api.ztrademm.com/api/address";
    try {
      Response response = await http.get(
        Uri.parse(url),
        headers: {
          "Authorization": "Bearer $token",
        },
      );

      if (response.statusCode == 200) {
        _address = addressFromJson(response.body);
        print('address successfully: ${response.body}');
        print("this is address ===>$address");
      } else {
        _error = response.statusCode.toString();
      }
    } catch (error) {
      _error = "This error is calling data from network :${error.toString()}";
    }
    _isLoading = false;
    notifyListeners();
  }

  orderCheckOut(String token, String payment) async {
    const String endpoint = "http://api.ztrademm.com/api/checkout";
    final url = Uri.parse(endpoint);

    final headers = {
      "Authorization": "Bearer $token",
    };

    try {
      Response response = await http.post(
        url,
        headers: headers,
        body: {
          "payment_option": payment,
        },
      );

      if (response.statusCode == 201) {
        print('order checkout successfully: ${response.body}');
        final responseBody = json.decode(response.body);
        _orderCheckOut = responseBody["status"];
        print("this is order checkout ======> $_orderCheckOut");
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
    _streetController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _countryController.dispose();
    _postalCodeController.dispose();
    _phoneController.dispose();
  }
}
