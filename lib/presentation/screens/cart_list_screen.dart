import 'package:beauty_clothes/presentation/providers/cart_provider.dart';
import 'package:beauty_clothes/presentation/widgets/cart_list_produit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartListScreen extends ConsumerStatefulWidget {
  const CartListScreen({super.key});

  @override
  ConsumerState<CartListScreen> createState() => _CartListScreenState();
}

class _CartListScreenState extends ConsumerState<CartListScreen> {
  @override
  Widget build(BuildContext context) {
    final produitsCart = ref.watch(cartListProvider);
    final count = ref.watch(cartCountProvider);
    final total = ref.watch(cartTotalProvider);

    return Column(
      children: [
        AppBar(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 2,
            children: [
              Icon(Icons.shopping_cart),
              Text(
                "Mon panier",
                style: TextStyle(
                  fontWeight: FontWeight.bold
                ),
              )
            ],
          ),
          centerTitle: true,
        ),

        // Liste du panier
        Expanded(
          child: (produitsCart.isEmpty) ?
          Center(
            child: Text(
              "Aucun produit dans le panier!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ) :
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10).copyWith(top: 0),
              child: Column(
                spacing: 10,
                children: produitsCart.map((produitPanier) =>
                  CartListProduit(
                    produitCart: produitPanier,
                  ),
                ).toList(),
              ),
            ),
          ),
        ),

        // Finaliser la commande
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Wrap(
            alignment: WrapAlignment.center,
            runSpacing: 10,
            children: [
              // Total du panier
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: const Color(0xFF0066B9),
                      width: 1,
                    )
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          children: [
                            Icon(Icons.attach_money),
                            Text(
                              "Total du panier",
                              style: TextStyle(
                                fontWeight: FontWeight.bold
                              ),
                            )
                          ],
                        ),
                      ),
                          
                      // Total
                      Expanded(
                        child: Container(
                          height: 32,
                          color: const Color(0x200066B9),
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          constraints: BoxConstraints(
                            minWidth: 30,
                          ),
                          child: Text(
                            "${(total * 100).round() / 100}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Bouton commander
              Expanded(
                child: FilledButton.icon(
                  onPressed: (count == 0) ? null : (){},
                  label: Text(
                    "Commander",
                    style: TextStyle(
                      fontSize: 20,
                    )
                  ),
                  icon: Icon(Icons.payment),
                  style: FilledButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: const Color(0xFF0066B9),
                  ),
                ),
              )
            ],
          ),
        )

      ],
    );
  }
}