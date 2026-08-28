import 'package:beauty_clothes/data/repositories/produit_repository_impl.dart';
import 'package:beauty_clothes/domain/entities/produit.dart';
import 'package:beauty_clothes/domain/repositories/produit_repository.dart';
import 'package:beauty_clothes/domain/usecases/get_produits.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Repository
final produitRepositoryProvider = Provider<ProduitRepository>((ref){
  return ProduitRepositoryImpl();
});

// UseCase
final getProduitsUseCaseProvider = Provider<GetProduits>((ref){
  final repository = ref.watch(produitRepositoryProvider);
  return GetProduits(repository);
});

// Liste tous les produits (Future)
final produitsListProvider = FutureProvider<List<Produit>>((ref) async{
  final usecase = ref.watch(getProduitsUseCaseProvider);
  return usecase.call();
});

// produit selon l'id
final produitByIdProvider = Provider.family<Produit?, int>((ref, id){
  final produitsAsync = ref.watch(produitsListProvider);
  return produitsAsync.maybeWhen(
    data: (produits) => produits.cast<Produit?>().firstWhere((p) =>
      p?.id == id,
      orElse: () => null,
    ),
    orElse: () => null,
  );
});