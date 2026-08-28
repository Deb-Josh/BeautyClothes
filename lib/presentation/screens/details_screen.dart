import 'package:beauty_clothes/presentation/providers/cart_provider.dart';
import 'package:beauty_clothes/presentation/providers/favorite_provider.dart';
import 'package:beauty_clothes/presentation/providers/produit_provider.dart';
import 'package:beauty_clothes/presentation/widgets/add_sub_buttons.dart';
import 'package:beauty_clothes/presentation/widgets/quantity_cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class DetailsScreen extends ConsumerStatefulWidget {
  const DetailsScreen({super.key, required this.id});

  final int id;

  static String fromPath = "/catalogue";

  @override
  ConsumerState<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends ConsumerState<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final produit = ref.watch(produitByIdProvider(widget.id));

    if(produit == null){
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    final isFavorite = ref.watch(isFavoriteProvider(produit.id));

    final isAddedCart = ref.watch(isAddedCartProvider(produit.id));

    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        leading: IconButton(
          onPressed: () => context.go(DetailsScreen.fromPath),
          icon: Icon(Icons.arrow_back)
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon(Icons.details),
            Text(
              "Détails du produit",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              )
            )
          ],
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => context.go("/panier"),
            icon: QuantityCart(
              icon: Icon(Icons.shopping_cart_outlined),
            ),
          )
        ],
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 10,
          children: [
            Container(
              width: double.infinity,
              height: 300,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0x500066B9),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey.withAlpha(100),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Hero(
                  tag: produit.id,
                  child: Image.network(
                    produit.image,
                    cacheWidth: 200,
                    fit: BoxFit.fitHeight,
                    errorBuilder: (context, error, stackTrace) => Icon(Icons.image, size: 100),
                  ),
                )
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    produit.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () =>
                    ref.read(favoriteProvider.notifier).toggle(produit.id),
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_outline,
                    color: Colors.red,
                  )
                )
              ],
            ),

            // Prix du produit
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "\$${produit.price}",
                  style: TextStyle(
                    color: const Color(0xFF0066B9),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  produit.category,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),

            // Description du produit
            Text(
              // faker.lorem.sentences(3).join(" "),
              produit.description,
              maxLines: 3,
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontStyle: FontStyle.italic,
              ),
            ),

            // definir le nomdre d'exemplaire du produit
            AddSubButtons(
              showLabel: true,
            ),

            // Bouton "Ajouter au panier"
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: FilledButton.icon(
                onPressed: (isAddedCart) ? null : (){
                  ref.read(cartListProvider.notifier).addToPanier(produit);
                },
                label: Text(
                  "Ajouter au panier",
                  style: TextStyle(
                    fontSize: 20,
                  )
                ),
                icon: Icon(Icons.add_shopping_cart),
                style: FilledButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: const Color(0xFF0066B9),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}