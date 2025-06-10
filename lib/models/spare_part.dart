class SparePart {
  final String id;
  final String name;
  final String category;
  final double price;
  final int stockQuantity;
  final String description;
  final String? imageUrl;

  SparePart({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.stockQuantity,
    required this.description,
    this.imageUrl,
  });

  SparePart copyWith({
    String? id,
    String? name,
    String? category,
    double? price,
    int? stockQuantity,
    String? description,
    String? imageUrl,
  }) {
    return SparePart(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      price: price ?? this.price,
      stockQuantity: stockQuantity ?? this.stockQuantity,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  bool get isLowStock => stockQuantity <= 5;
  bool get isOutOfStock => stockQuantity == 0;
}
