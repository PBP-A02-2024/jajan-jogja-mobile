import 'package:flutter/material.dart';
import 'package:jajan_jogja_mobile/farrel/widgets/food_card.dart';

class RestaurantCard extends StatelessWidget {
  final String restaurantName;
  final String address;
  final double distance;
  final List<Map<String, dynamic>> foods;

  const RestaurantCard({
    Key? key,
    required this.restaurantName,
    required this.address,
    required this.distance,
    required this.foods,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.orange, width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 5,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            restaurantName,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Theme.of(context).colorScheme.secondary,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          SizedBox(height: 4),
          Text(
            address,
            style: TextStyle(color: Colors.grey, fontSize: 14),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          SizedBox(height: 4),
          Text(
            '${distance.toStringAsFixed(1)} km away',
            style: TextStyle(color: Colors.orange, fontSize: 14),
          ),
          SizedBox(height: 16),
          SizedBox(
            height: 250, // Adjust height based on FoodCard
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: foods.length,
                itemBuilder: (context, index) {
                  final food = foods[index];
                  return FoodCard(
                    name: food['name'] ?? 'Unknown',
                    description:
                        food['description'] ?? 'No description available',
                    price: food['price'] ?? '0.00',
                    imageUrl:
                        food['imageUrl'] ?? 'https://via.placeholder.com/150',
                  );
                }),
          ),
        ],
      ),
    );
  }
}
