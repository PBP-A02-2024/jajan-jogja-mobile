import 'package:flutter/material.dart';

import '../models/makanan.dart';

class FoodCard extends StatelessWidget {
  final Makanan food;
  final VoidCallback onAddToPlan;

  const FoodCard({
    Key? key,
    required this.food,
    required this.onAddToPlan,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFC98809), width: 4),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            // Food Image
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                food.fields.fotoLink,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Center(child: Text('Image not available'));
                },
              ),
            ),
            const SizedBox(width: 16),
            // Food Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    food.fields.nama,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF7C1D05),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    food.fields.description,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF7A7A7A),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Rp${food.fields.harga}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF7C1D05),
                    ),
                  ),
                ],
              ),
            ),
            // Add to Food Plan
            IconButton(
              icon: const Icon(Icons.add_circle_outline),
              color: const Color(0xFFE43D12),
              onPressed: onAddToPlan,
            ),
          ],
        ),
      ),
    );
  }
}
