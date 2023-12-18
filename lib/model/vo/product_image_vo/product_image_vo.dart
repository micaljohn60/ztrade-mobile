class ProductImage {
  final int id;
  final String thumbnails;
  final int productId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String fullThumbnailLink;

  ProductImage({
    this.fullThumbnailLink,
    this.id,
    this.thumbnails,
    this.productId,
    this.createdAt,
    this.updatedAt,
  });

  factory ProductImage.fromJson(Map<String, dynamic> json) => ProductImage(
        id: json["id"],
        thumbnails: json["thumbnails"],
        productId: json["product_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        fullThumbnailLink: json["full_thumbnail_link"],
      );

  Map<String, dynamic> toJson() => {
        "full_thumbnail_link": fullThumbnailLink,
        "id": id,
        "thumbnails": thumbnails,
        "product_id": productId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
