class Category {
  final int id;
  final String name;
  final String image;
  final String number;
  final String uniqueId;
  final DateTime createdAt;
  final DateTime updatedAt;

  Category({
    this.id,
    this.name,
    this.image,
    this.number,
    this.uniqueId,
    this.createdAt,
    this.updatedAt,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        number: json["number"],
        uniqueId: json["unique_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "number": number,
        "unique_id": uniqueId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
