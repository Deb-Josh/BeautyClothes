// providers.dart
import 'package:beauty_clothes/domain/entities/produit.dart';
import 'package:beauty_clothes/presentation/providers/produit_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UrlFilter extends Notifier<String> {
  @override
  String build() => 'Tout';
  void set(String value) => state = value;
}

final urlFilterProvider = NotifierProvider<UrlFilter, String>(UrlFilter.new);

final categoriesProvider = Provider<List<String>>((ref){
  final produits = ref.watch(produitsListProvider).value ?? [];
  return ["Tout", ...produits.map((e) => e.category).toSet()];
});

final filteredProduitsProvider = Provider<AsyncValue<List<Produit>>>((ref){
  final produitsAsync = ref.watch(produitsListProvider);
  // On lit le filtre directement depuis l'URL
  final currentFilter = ref.watch(urlFilterProvider);

  return produitsAsync.whenData((produits) {
    if (currentFilter == 'Tout') return produits;
    return produits.where((p) => p.category == currentFilter).toList();
  });
});