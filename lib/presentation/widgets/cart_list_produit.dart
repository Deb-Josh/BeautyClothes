import 'package:beauty_clothes/domain/entities/produit_panier.dart';
import 'package:beauty_clothes/presentation/providers/cart_provider.dart';
import 'package:beauty_clothes/presentation/widgets/add_sub_buttons.dart';
import 'package:beauty_clothes/presentation/widgets/card_produit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartListProduit extends CardProduit {
  CartListProduit({
    super.key,
    super.index,
    super.image,
    super.title,
    super.price,
    this.produitCart,
  });

  final ProduitPanier? produitCart;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final produit = produitCart?.produit;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color(0xFF0066B9),
          width: 1,
        )
      ),
      child: Row(
        spacing: 20,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              width: 100,
              height: 120,
              color: Colors.grey.withAlpha(60),
              child: Image.network(
                produit?.image ?? image,
                fit: BoxFit.cover,
                cacheWidth: 200,
                errorBuilder: (context, error, stackTrace) => Icon(Icons.image, size: 50),
              ),
            ),
          ),
          Expanded(
            child: Column(
              spacing: 20,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        produit?.title ?? title,
                        maxLines: 2,
                        overflow: TextOverflow.fade,
                        style: TextStyle(
                          fontSize: 18,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.red.withAlpha(50),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: IconButton(
                        onPressed: (){
                          ref.read(cartListProvider.notifier).removeFromPanier(produit?.id ?? index!);
                        },
                        icon: Icon(Icons.delete, color: Colors.red),
                        tooltip: "Supprimer du panier",
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "\$${produit?.price ?? price}",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF0066B9),
                      ),
                    ),

                    // Les boutons de controle du nombre d'exemplaires d'un produit
                    AddSubButtons(produitId: produit?.id),
                  ],
                )
              ],
            ),
          ),
        ],
      )
    );
  }
}