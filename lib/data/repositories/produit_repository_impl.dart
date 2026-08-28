import 'dart:convert';

import 'package:beauty_clothes/data/models/produit_model.dart';
import 'package:beauty_clothes/domain/entities/produit.dart';
import 'package:beauty_clothes/domain/repositories/produit_repository.dart';
import 'package:http/http.dart' as http;

class ProduitRepositoryImpl implements ProduitRepository {
  @override
  Future<List<Produit>> getProduits() async{
    final result = await http.get(Uri.parse("https://fakestoreapi.com/products"));
    final List<dynamic> data = jsonDecode(result.body);
    return data.map((produit) =>
      ProduitModel.fromJson(produit)
    ).toList();
  }
  
}