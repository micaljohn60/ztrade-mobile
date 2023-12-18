import '../product_vo/product_vo.dart';

class Datum {
  final int id;
  final String sessionKey;
  final int userId;
  final int productId;
  int quantity;
  final int singlePrice;
  final int totalPrice;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Product product;

  Datum({
    this.id,
    this.sessionKey,
    this.userId,
    this.productId,
    this.quantity,
    this.singlePrice,
    this.totalPrice,
    this.createdAt,
    this.updatedAt,
    this.product,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        sessionKey: json["session_key"],
        userId: json["user_id"],
        productId: json["product_id"],
        quantity: json["quantity"],
        singlePrice: json["single_price"],
        totalPrice: json["total_price"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        product: Product.fromJson(json["product"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "session_key": sessionKey,
        "user_id": userId,
        "product_id": productId,
        "quantity": quantity,
        "single_price": singlePrice,
        "total_price": totalPrice,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "product": product.toJson(),
      };
}
