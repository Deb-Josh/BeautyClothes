import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'cart_provider.dart';

final cartLengthProvider = Provider<int>((ref) {
  return ref.watch(cartListProvider).length;
});

final cartTotalProvider = Provider<double>((ref) {
  return ref.watch(cartListProvider.notifier).totalPrice;
});