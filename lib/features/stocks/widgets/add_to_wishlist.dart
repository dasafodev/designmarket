import 'package:flutter/material.dart';

class AddToWishlist extends StatelessWidget {
  const AddToWishlist({
    super.key,
    this.onTap,
  });

  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: const Color(0xFFEEF2F6),
        ),
        width: 160,
        child: const Center(
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
