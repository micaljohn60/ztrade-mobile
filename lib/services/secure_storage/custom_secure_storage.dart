import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CustomSecureStorage{

  CustomSecureStorage();

  final _storage = const FlutterSecureStorage();

  Future<String> readValue() async{
    String value = await _storage.read(key: 'token');
    return value;
  }

   Future<String> readValueName(String name) async{
    String value = await _storage.read(key: name);
    return value;
  }

  Future writeData(String key, String value)  async {
    var writeData = await _storage.write(key: key, value: value);
    return writeData;
  }

   Future deleteData(String key) async{
    var deleteData = await _storage.delete(key: key);
    return deleteData;
  }
}