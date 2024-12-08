import 'package:flutter/material.dart';

class FoodPlanCard extends StatelessWidget {
  final String title; // For "Nama Itinerary"
  final String distance; // For "Jarak Antar Lokasi"
  final VoidCallback onTap; // Callback for navigation

  const FoodPlanCard({
    Key? key,
    required this.title,
    required this.distance,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // Trigger navigation or custom behavior
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
        decoration: BoxDecoration(
          color: const Color(0xFFFFF8E5), // Light cream background color
          border: Border.all(
            color: const Color(0xFFFFA726), // Orange border color
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Column(
          children: [
            // Title Section
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF944434), // Dark brown color
              ),
            ),
            const SizedBox(height: 8.0),
            // Distance Section
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.lightbulb, // Bulb icon
                  color: const Color(0xFFFFA726), // Orange color
                  size: 20.0,
                ),
                const SizedBox(width: 8.0),
                Text(
                  distance,
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.normal,
                    color: Color(0xFF944434), // Dark brown color
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
