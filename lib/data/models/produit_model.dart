import 'package:beauty_clothes/domain/entities/produit.dart';

class ProduitModel extends Produit {
  ProduitModel({
    required super.id,
    required super.title,
    required super.image,
    required super.price,
    required super.category,
    required super.description,
  });

  factory ProduitModel.fromJson(Map<String, dynamic> json) => ProduitModel(
    id: (json["id"] as num).toInt(),
    title: json["title"] as String,
    image: json["image"] as String,
    price: (json["price"] as num).toDouble(),
    category: json["category"] as String,
    description: json["description"] as String,
  );
  
}