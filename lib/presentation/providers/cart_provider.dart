import 'dart:convert';
import 'package:beauty_clothes/domain/entities/produit.dart';
import 'package:beauty_clothes/domain/entities/produit_panier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

extension ProduitJson on Produit{

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "image": image,
    "price": price,
    "category": category,
    "description": description,
  };

  static Produit fromJson(Map<String, dynamic> json) => Produit(
    id: (json["id"] as num).toInt(),
    title: json["title"] as String,
    image: json["image"] as String,
    price: (json["price"] as num).toDouble(),
    category: json["category"] as String,
    description: json["description"] as String,
  );

}

final cartListProvider = NotifierProvider<CartListNotifier, List<ProduitPanier>>(CartListNotifier.new);

class CartListNotifier extends Notifier<List<ProduitPanier>>{
  static const _key = "panier_data";

  @override
  List<ProduitPanier> build(){
    _loadPanier();
    return [];
  }

  void incrementQuantity(int produitId){
    final index = state.indexWhere((e) => e.produit.id == produitId);

    if(index == -1) return;
    
    state = [
      for (int i = 0; i < state.length; i++)
        if (i == index) state[i].copyWith(quantity: state[i].quantity + 1)
        else state[i]
    ];
    _savePanier();
  }

  void decrementQuantity(int produitId){
    final index = state.indexWhere((e) => e.produit.id == produitId);

    if(index == -1) return;

    if(state[index].quantity > 1){
      state = [
        for (int i = 0; i < state.length; i++)
          if (i == index) state[i].copyWith(quantity: state[i].quantity - 1)
          else state[i]
      ];
    }
    _savePanier();
  }

  void addToPanier(Produit produit, [int quantity = 1]){
    state = [
      ...state,
      ProduitPanier(produit: produit, quantity: quantity)
    ];
    _savePanier();
  }

  void removeFromPanier(int produitId){
    state = state.where((p) => p.produit.id!= produitId).toList();
    _savePanier();
  }

  void clearPanier(){
    state = [];
    _savePanier();
  }

  double get totalPrice => state.fold(0, (sum, item) => sum + (item.produit.price * item.quantity));

  int get count => state.fold(0, (sum, item) => sum + item.quantity);

  Future<void> _savePanier() async{
    final prefs = await SharedPreferences.getInstance();
    final jsonList = state.map((p) => jsonEncode(p.toJson())).toList();
    await prefs.setStringList(_key, jsonList);
  }

  Future<void> _loadPanier() async{
    final prefs = await SharedPreferences.getInstance();
    final jsonList = prefs.getStringList(_key);
    if(jsonList!= null){
      state = jsonList.map((e) => ProduitPanier.fromJson(jsonDecode(e))).toList();
    }
  }
}

// Les helpers pour utiliser dans l'UI
final cartCountProvider = Provider<int>((ref) {
  final cart = ref.watch(cartListProvider);
  return cart.fold(0, (sum, item) => sum + item.quantity);
});

final cartTotalProvider = Provider<double>((ref) {
  final cart = ref.watch(cartListProvider);
  return cart.fold(0, (sum, item) => sum + (item.produit.price * item.quantity));
});

final isAddedCartProvider = Provider.family<bool, int>((ref, produitId){
  final cart = ref.watch(cartListProvider);
  return cart.any((e) => e.produit.id == produitId);
});

final cartQuantityProvider = Provider.family<int, int?>((ref, produitId){
  final cart = ref.watch(cartListProvider);
  try {
    return cart.firstWhere((e) => e.produit.id == produitId).quantity;
  } catch (_) {
    return 0;
  }
});