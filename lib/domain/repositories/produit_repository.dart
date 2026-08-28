import 'package:beauty_clothes/domain/entities/produit.dart';

abstract class ProduitRepository {
  Future<List<Produit>> getProduits();
}