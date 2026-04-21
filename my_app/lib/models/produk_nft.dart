class Product { 
  int id;
  String name;
  String image;
  double price;
  String description;

  Product({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.description,
  });

  factory Product.fromJson(Map<String, dynamic> json) { 
    return Product(
      id: json["id"],
      name: json["name"],
      image: json["image"],
      price: (json["price"] as num).toDouble(),
      description: json["description"],
    );
  }
}
