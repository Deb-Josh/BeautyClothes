import 'package:beauty_clothes/presentation/providers/filter_provider.dart';
import 'package:beauty_clothes/presentation/providers/sort_provider.dart';
import 'package:beauty_clothes/presentation/widgets/card_produit.dart';
import 'package:beauty_clothes/presentation/widgets/filter_button.dart';
import 'package:beauty_clothes/presentation/widgets/sort_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CatalogueScreen extends ConsumerStatefulWidget {
  const CatalogueScreen({super.key, this.filter, this.sort});
  final String? filter;
  final String? sort;

  @override
  ConsumerState<CatalogueScreen> createState() => _CatalogueScreenState();
}

class _CatalogueScreenState extends ConsumerState<CatalogueScreen> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(urlFilterProvider.notifier).set(widget.filter ?? 'Tout');
      ref.read(urlSortProvider.notifier).set(widget.sort ?? 'Aléatoire');
    });
  }

  @override
  void didUpdateWidget(covariant CatalogueScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.filter != widget.filter || oldWidget.sort != widget.sort) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(urlFilterProvider.notifier).set(widget.filter ?? 'Tout');
        ref.read(urlSortProvider.notifier).set(widget.sort ?? 'Aléatoire');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final filteredAsync = ref.watch(filteredSortedProduitsProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        title: Row(
          spacing: 2,
          children: [
            Icon(Icons.home),
            Text("Beauty Clothes", style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),
          IconButton(onPressed: () {}, icon: Icon(Icons.notifications_outlined)),
        ],
      ),
      body: Column(
        spacing: 10,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [FilterButton(), SortButton()],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: filteredAsync.when(
                data: (produits) {
                  if (produits.isEmpty) {
                    return Center(child: Text("Aucun produit pour ${widget.filter}"));
                  }
                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 10,
                      childAspectRatio: 0.6,
                    ),
                    itemCount: produits.length,
                    itemBuilder: (context, index) => CardProduit(
                      produit: produits[index],
                      fromApi: true,
                    ),
                  );
                },
                loading: () => Center(child: CircularProgressIndicator()),
                error: (e, s) => Center(child: Text("Erreur : $e")),
              ),
            ),
          ),
        ],
      ),
    );
  }
}