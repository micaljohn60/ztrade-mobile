import '../categorry_vo/category_vo.dart';
import '../product_image_vo/product_image_vo.dart';

class Product {
  final int id;
  final String name;
  final String price;
  final String itemDescription;
  final int categoryId;
  final int percentageId;
  final dynamic storeId;
  final dynamic subcategoryId;
  final String itemId;
  final String newArrival;
  final String mostPopular;
  final String topSelling;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Category category;
  final dynamic subCategory;
  final List<ProductImage> productImage;

  Product({
    this.id,
    this.name,
    this.price,
    this.itemDescription,
    this.categoryId,
    this.percentageId,
    this.storeId,
    this.subcategoryId,
    this.itemId,
    this.newArrival,
    this.mostPopular,
    this.topSelling,
    this.createdAt,
    this.updatedAt,
    this.category,
    this.subCategory,
    this.productImage,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        itemDescription: json["item_description"],
        categoryId: json["category_id"],
        percentageId: json["percentage_id"],
        storeId: json["store_id"],
        subcategoryId: json["subcategory_id"],
        itemId: json["item_id"],
        newArrival: json["new_arrival"],
        mostPopular: json["most_popular"],
        topSelling: json["top_selling"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        category: Category.fromJson(json["category"]),
        subCategory: json["sub_category"],
        productImage: List<ProductImage>.from(
            json["product_image"].map((x) => ProductImage.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "item_description": itemDescription,
        "category_id": categoryId,
        "percentage_id": percentageId,
        "store_id": storeId,
        "subcategory_id": subcategoryId,
        "item_id": itemId,
        "new_arrival": newArrival,
        "most_popular": mostPopular,
        "top_selling": topSelling,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "category": category.toJson(),
        "sub_category": subCategory,
        "product_image":
            List<dynamic>.from(productImage.map((x) => x.toJson())),
      };
}
