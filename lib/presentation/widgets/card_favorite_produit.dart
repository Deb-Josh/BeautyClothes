import 'package:beauty_clothes/presentation/providers/favorite_provider.dart';
import 'package:beauty_clothes/presentation/screens/details_screen.dart';
import 'package:beauty_clothes/presentation/widgets/card_produit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CardFavoriteProduit extends CardProduit {
  CardFavoriteProduit({
    super.key,
    super.index,
    super.image,
    super.title,
    super.price,
    super.produit,
    super.fromApi,
  });


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFavorite = ref.watch(isFavoriteProvider(produit?.id ?? index!));

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0x200066B9),
        borderRadius: BorderRadius.circular(10),
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
              child: (!fromApi) ?
                Image.asset(image) :
                Image.network(
                  produit?.image ??
                  "$image${(index != null) ? '?random=$index' : ''}",
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
                        color: Colors.white.withAlpha(160),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: IconButton(
                        onPressed: () =>
                          ref.read(favoriteProvider.notifier).toggle(produit?.id ?? index!),
                        icon: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_outline,
                          color: Colors.red
                        ),
                        tooltip: "Supprimer des favoris",
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
                    FilledButton(
                      onPressed: (){
                        DetailsScreen.fromPath = "/favoris";
                        context.go("/details/${produit?.id ?? index}");
                      },
                      style: FilledButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white
                      ),
                      child: Text("détails")
                    )
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