import 'package:beauty_clothes/presentation/providers/cart_summary_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QuantityCart extends ConsumerWidget {
  const QuantityCart({super.key, required this.icon});

  final Widget icon;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartLength = ref.watch(cartLengthProvider);

    return cartLength == 0 ?
    icon :
    Stack(
      clipBehavior: Clip.none,
      children: [
        icon,
        Positioned(
          top: 0,
          left: -10,
          child: Container(
            padding: EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(100),
            ),
            constraints: BoxConstraints(
              minWidth: 15,
            ),
            child: Center(
              child: Text(
                "$cartLength",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                )
              )
            )
          ),
        )
      ],
    );
  }
}