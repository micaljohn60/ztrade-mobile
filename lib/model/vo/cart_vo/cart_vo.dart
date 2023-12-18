// To parse this JSON data, do
//
//     final carts = cartsFromJson(jsonString);

import 'dart:convert';

import '../data_vo/data_vo.dart';

Carts cartsFromJson(String str) => Carts.fromJson(json.decode(str));

String cartsToJson(Carts data) => json.encode(data.toJson());

class Carts {
  final String status;
  final String message;
  final List<Datum> data;

  Carts({
    this.status,
    this.message,
    this.data,
  });

  factory Carts.fromJson(Map<String, dynamic> json) => Carts(
        status: json["status"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}
