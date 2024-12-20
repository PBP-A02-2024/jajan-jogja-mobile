import 'package:flutter/material.dart';
import 'package:jajan_jogja_mobile/farrel/widgets/food_card.dart';

class RestaurantCard extends StatelessWidget {
  final String restaurantPk; // Added this line
  final String restaurantName;
  final String address;
  final double distance;
  final List<Map<String, dynamic>> foods;
  final bool isEditingItems;
  final VoidCallback? onRestaurantTap;
  final Function(String) onDeleteRestaurant; // Callback with restaurant PK
  final Function(Map<String, dynamic>)? onFoodTap;
  final Function(String) onDeleteFood; // Callback with food PK

  const RestaurantCard({
    Key? key,
    required this.restaurantPk, // Added this line
    required this.restaurantName,
    required this.address,
    required this.distance,
    required this.foods,
    this.isEditingItems = false,
    this.onRestaurantTap,
    required this.onDeleteRestaurant,
    this.onFoodTap,
    required this.onDeleteFood,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFEBE9E1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.orange, width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 5,
            offset: const Offset(2, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: isEditingItems ? onRestaurantTap : null,
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
                      const SizedBox(height: 4),
                      Text(
                        address,
                        style:
                            const TextStyle(color: Colors.grey, fontSize: 14),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ],
                  ),
                ),
              ),
              if (isEditingItems)
                IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Delete Restaurant'),
                          content: const Text(
                              'Are you sure you want to delete this restaurant?'),
                          actions: [
                            TextButton(
                              child: const Text('Cancel'),
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                            TextButton(
                              child: const Text(
                                'Delete',
                                style: TextStyle(color: Colors.red),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                                onDeleteRestaurant(restaurantPk);
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
            ],
          ),
          const SizedBox(height: 16),
          // List of Food Items
          SizedBox(
            height: 250,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: foods.length,
              itemBuilder: (context, index) {
                final food = foods[index];
                return Stack(
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (isEditingItems && onFoodTap != null) {
                          onFoodTap!(food);
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FoodCard(
                          name: food['name'] ?? 'Unknown',
                          description:
                              food['description'] ?? 'No description available',
                          price: food['price'] ?? '0',
                          imageUrl: food['imageUrl'] ??
                              'https://via.placeholder.com/150',
                        ),
                      ),
                    ),
                    if (isEditingItems)
                      Positioned(
                        top: 0,
                        right: 0,
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Delete Food'),
                                  content: const Text(
                                      'Are you sure you want to delete this food item?'),
                                  actions: [
                                    TextButton(
                                      child: const Text('Cancel'),
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                    ),
                                    TextButton(
                                      child: const Text(
                                        'Delete',
                                        style: TextStyle(color: Colors.red),
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        onDeleteFood(
                                            food['pk'].toString()); // Pass pk
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
