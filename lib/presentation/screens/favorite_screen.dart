import 'package:beauty_clothes/presentation/providers/favorite_provider.dart';
import 'package:beauty_clothes/presentation/providers/produit_provider.dart';
import 'package:beauty_clothes/presentation/widgets/card_favorite_produit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoriteScreen extends ConsumerStatefulWidget {
  const FavoriteScreen({super.key});

  @override
  ConsumerState<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends ConsumerState<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    final favoritesId = ref.watch(favoriteProvider);
    final allProduits = ref.watch(produitsListProvider).value ?? [];

    final favoritesProduits = allProduits.where(
      (p) =>
      favoritesId.contains(p.id)
    ).toList();

    return Column(
      children: [
        AppBar(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 2,
            children: [
              Icon(Icons.favorite),
              Text(
                "Mes favoris",
                style: TextStyle(
                  fontWeight: FontWeight.bold
                ),
              ),
            ],
          ),
          centerTitle: true,
        ),

        // Liste des produits favoris
        Expanded(
          child: (favoritesProduits.isEmpty)
          ? Center(
            child: Text(
              "Vous n'avez aucun produit favori!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          )
          : SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10).copyWith(top: 0),
              child: Column(
                spacing: 10,
                children: favoritesProduits.map((produit) =>
                  CardFavoriteProduit(
                    produit: produit,
                    fromApi: true,
                  ),
                ).toList(),
              ),
            ),
          ),
        )
      ],
    );
  }
}