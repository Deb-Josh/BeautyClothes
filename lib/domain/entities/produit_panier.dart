import 'package:beauty_clothes/domain/entities/produit.dart';
import 'package:beauty_clothes/presentation/providers/cart_provider.dart';

class ProduitPanier {
  final Produit produit;
  final int quantity;

  ProduitPanier({required this.produit, this.quantity = 1});

  ProduitPanier copyWith({int? quantity}) {
    return ProduitPanier(
      produit: produit,
      quantity: quantity?? this.quantity
    );
  }

  Map<String, dynamic> toJson() => {
    "produit": produit.toJson(),
    "quantity": quantity,
  };

  factory ProduitPanier.fromJson(Map<String, dynamic> json) => ProduitPanier(
    produit: ProduitJson.fromJson(json["produit"]),
    quantity: json["quantity"] as int,
  );
}