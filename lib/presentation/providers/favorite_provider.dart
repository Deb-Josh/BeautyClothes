import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final favoriteProvider = NotifierProvider<FavoriteNotifier, List<int>>(FavoriteNotifier.new);

class FavoriteNotifier extends Notifier<List<int>> {
  static const _key = "favorites";

  @override
  List<int> build(){
    _load();
    return [];
  }

  void toggle(int id){
    if(state.contains(id)){
      state = state.where((e) => e != id).toList();
    }else{
      state = [
        ...state, id
      ];
    }
    _save();
  }

  Future<void> _save() async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_key, state.map((e) => e.toString()).toList());
  }

  Future<void> _load() async{
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(_key);
    if(list != null){
      state = list.map((e) => int.parse(e)).toList();
    }
  }

}

final isFavoriteProvider = Provider.family<bool, int>((ref, id){
  final fav = ref.watch(favoriteProvider);
  return fav.contains(id);
});