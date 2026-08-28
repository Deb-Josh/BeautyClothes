import 'package:beauty_clothes/domain/entities/produit.dart';
import 'package:beauty_clothes/domain/repositories/produit_repository.dart';

class GetProduits {
  final ProduitRepository repository;

  GetProduits(this.repository);

  Future<List<Produit>> call() => repository.getProduits();
}