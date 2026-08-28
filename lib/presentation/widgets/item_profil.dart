import 'package:flutter/material.dart';

class ItemProfil extends StatelessWidget {
  const ItemProfil({super.key, required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(100),
              blurRadius: 2,
            )
          ]
        ),
        child: Row(
          spacing: 5,
          children: [
            Icon(icon),
            Text(label)
          ],
        ),
      ),
    );
  }
}