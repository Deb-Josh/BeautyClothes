import 'dart:math';

import 'package:beauty_clothes/domain/entities/produit.dart';
import 'package:beauty_clothes/presentation/providers/favorite_provider.dart';
import 'package:beauty_clothes/presentation/screens/details_screen.dart';
import 'package:faker/faker.dart' hide Color, Image;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CardProduit extends ConsumerWidget {
  CardProduit({
    super.key,
    this.index,
    this.image = "https://picsum.photos/150/170",
    String? title,
    double? price,
    this.fromApi = false,

    this.produit,
  }) :
  title = title ?? faker.lorem.words(Random().nextDouble().round() + 2).join(" "),
  price = price ?? (((Random().nextDouble() * 10 + 1) * 50) * 100).round() / 100;

  final int? index;
  final String image;
  final String title;
  final double price;
  final bool fromApi;

  final Produit? produit;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFavorite = ref.watch(isFavoriteProvider(produit?.id ?? index!));

    return SizedBox(
      width: 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 2,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              // background
              Container(
                width: double.infinity,
                height: 220,
                decoration: BoxDecoration(
                  color: const Color(0x200066B9),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
    
              // Image du vetement
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  width: 150,
                  height: 170,
                  color: Colors.grey.withAlpha(60),
                  child: Hero(
                    tag: produit?.id ?? image,
                    child: (!fromApi) ?
                      Image.asset(image) :
                      Image.network(
                        produit?.image ??
                        "$image${(index != null) ? '?random=$index' : ''}",
                        cacheWidth: 200,
                        errorBuilder: (context, error, stacktrace) => Icon(Icons.image, size: 50),
                      ),
                  ),
                ),
              ),
    
              // Bouton favoris
              Positioned(
                top: 2,
                right: 2,
                child: Container(
                  // padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(180),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: IconButton(
                    onPressed: () =>
                      ref.read(favoriteProvider.notifier).toggle(produit?.id ?? index!),
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_outline,
                      color: Colors.red
                    ),
                    tooltip: "définir comme favori",
                  ),
                ),
              )
            ],
          ),
      
          // Nom du vetement
          SizedBox(
            width: double.infinity,
            child: Text(
              produit?.title ?? title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
      
          // Prix du vetement
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
          
              // Bouton pour acceder aux details du produit
              FilledButton(
                onPressed: (){
                  DetailsScreen.fromPath = "/catalogue";
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
    );
  }
}