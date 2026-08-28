import 'package:beauty_clothes/domain/entities/produit.dart';
import 'filter_provider.dart';
import 'produit_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UrlSort extends Notifier<String> {
  @override
  String build() => 'Aléatoire';

  void set(String value) => state = value;
}

final urlSortProvider = NotifierProvider<UrlSort, String>(UrlSort.new);

final filteredSortedProduitsProvider = Provider<AsyncValue<List<Produit>>>((ref) {
  final produitsAsync = ref.watch(produitsListProvider);
  final currentFilter = ref.watch(urlFilterProvider);
  final currentSort = ref.watch(urlSortProvider);

  return produitsAsync.whenData((produits) {
    var list = currentFilter == 'Tout'
        ? [...produits]
        : produits.where((p) => p.category == currentFilter).toList();

    if (currentSort == 'A->Z') {
      list.sort((a, b) => a.title.toLowerCase().compareTo(b.title.toLowerCase()));
    } else if (currentSort == 'Z->A') {
      list.sort((a, b) => b.title.toLowerCase().compareTo(a.title.toLowerCase()));
    }

    return list;
  });
});