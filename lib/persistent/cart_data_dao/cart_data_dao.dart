import 'package:hive/hive.dart';
part 'cart_data_dao.g.dart';

@HiveType(typeId: 0)
class CartDAO extends HiveObject {
  @HiveField(0)
  String productName;
  @HiveField(1)
  String productId;
  @HiveField(2)
  String price;
  @HiveField(3)
  int quantity;
  @HiveField(4)
  String category;

  CartDAO(this.productName, this.productId, this.price, this.quantity,
      this.category);
}
