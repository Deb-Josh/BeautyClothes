import 'package:beauty_clothes/presentation/providers/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddSubButtons extends ConsumerStatefulWidget {
  const AddSubButtons({
    super.key,
    this.produitId,
    this.showLabel = false,
  });

  final int? produitId;
  final bool showLabel;

  @override
  ConsumerState<AddSubButtons> createState() => _AddSubButtonsState();
}

class _AddSubButtonsState extends ConsumerState<AddSubButtons> {
  int _nExemplary = 1;

  void _decrementExemplary(){
    setState(() => (_nExemplary > 1) ? _nExemplary-- : _nExemplary);
  }

  void _incrementExemplary(){
    setState(() => _nExemplary++);
  }

  @override
  Widget build(BuildContext context) {
    final quantity = ref.watch(cartQuantityProvider(widget.produitId));

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color(0xFF0066B9),
          width: 1,
        )
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // decrementer le nombre d'exemplaires
          TextButton.icon(
            onPressed: (widget.produitId == null) ?
              _decrementExemplary :
              () => ref.read(cartListProvider.notifier).decrementQuantity(widget.produitId!),
            label: Text(
              (widget.showLabel) ?
              "Diminuer" : "",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              )
            ),
            icon: Icon(Icons.remove, size: 20, color: const Color(0xFF0066B9)),
          ),

          // Le nombre d'exemplaires
          Container(
            height: 32,
            color: const Color(0x200066B9),
            constraints: BoxConstraints(
              minWidth: 30,
            ),
            child: Center(
              child: Text(
                "${quantity == 0 ? _nExemplary : quantity}",
                style: TextStyle(
                  fontWeight: FontWeight.bold
                ),
              )
            ),
          ),

          // incrementer le nombre d'exemplaires
          TextButton.icon(
            onPressed: (widget.produitId == null) ?
              _incrementExemplary :
              () => ref.read(cartListProvider.notifier).incrementQuantity(widget.produitId!),
            label: Text(
              (widget.showLabel) ?
              "Augmenter" : "",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              )
            ),
            icon: Icon(Icons.add, size: 20, color: const Color(0xFF0066B9)),
          ),
        ],
      ),
    );
  }
}