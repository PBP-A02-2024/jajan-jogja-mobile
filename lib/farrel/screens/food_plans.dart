import "package:flutter/material.dart";
import "package:jajan_jogja_mobile/widgets/navbar.dart";
import 'package:jajan_jogja_mobile/widgets/header_app.dart';
import 'package:jajan_jogja_mobile/farrel/widgets/restaurant_card.dart';

class FoodPlans extends StatelessWidget {
  const FoodPlans({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> restaurants = [
      {
        'restaurantName': 'Restoran Lezat Nusantara',
        'address': 'Jl. Raya Merdeka No. 123, Jakarta',
        'distance': 5.4,
        'foods': [
          {
            'name': 'Rendang Padang',
            'description': 'Rendang khas Padang yang gurih dan pedas.',
            'price': '50.000',
            'imageUrl': 'https://via.placeholder.com/150',
          },
          {
            'name': 'Sate Ayam',
            'description': 'Sate ayam dengan bumbu kacang yang lezat.',
            'price': '30.000',
            'imageUrl': 'https://via.placeholder.com/150',
          },
          {
            'name': 'Nasi Goreng Spesial',
            'description': 'Nasi goreng dengan telur, ayam, dan udang.',
            'price': '25.000',
            'imageUrl': 'https://via.placeholder.com/150',
          },
        ],
      },
      {
        'restaurantName': 'Western Grill House',
        'address': 'Jl. Sunset Road No. 45, Bali',
        'distance': 3.2,
        'foods': [
          {
            'name': 'Grilled Chicken',
            'description': 'Chicken grilled to perfection with herbs.',
            'price': '60.000',
            'imageUrl': 'https://via.placeholder.com/150',
          },
          {
            'name': 'Beef Burger',
            'description': 'Juicy beef burger with cheese and fries.',
            'price': '70.000',
            'imageUrl': 'https://via.placeholder.com/150',
          },
          {
            'name': 'Pasta Carbonara',
            'description': 'Creamy carbonara pasta with bacon.',
            'price': '55.000',
            'imageUrl': 'https://via.placeholder.com/150',
          },
        ],
      },
      {
        'restaurantName': 'Warung Makan Sehat',
        'address': 'Jl. Pahlawan No. 78, Surabaya',
        'distance': 1.8,
        'foods': [
          {
            'name': 'Gado-Gado',
            'description': 'Salad with peanut sauce dressing.',
            'price': '20.000',
            'imageUrl': 'https://via.placeholder.com/150',
          },
          {
            'name': 'Ayam Penyet',
            'description': 'Fried chicken with sambal and rice.',
            'price': '30.000',
            'imageUrl': 'https://via.placeholder.com/150',
          },
          {
            'name': 'Soto Ayam',
            'description': 'Indonesian chicken soup with turmeric.',
            'price': '25.000',
            'imageUrl': 'https://via.placeholder.com/150',
          },
          {
            'name': 'Gado-Gado',
            'description': 'Salad with peanut sauce dressing.',
            'price': '20.000',
            'imageUrl': 'https://via.placeholder.com/150',
          },
          {
            'name': 'Gado-Gado',
            'description': 'Salad with peanut sauce dressing.',
            'price': '20.000',
            'imageUrl': 'https://via.placeholder.com/150',
          },
          {
            'name': 'Gado-Gado',
            'description': 'Salad with peanut sauce dressing.',
            'price': '20.000',
            'imageUrl': 'https://via.placeholder.com/150',
          },
          {
            'name': 'Gado-Gado',
            'description': 'Salad with peanut sauce dressing.',
            'price': '20.000',
            'imageUrl': 'https://via.placeholder.com/150',
          },
          {
            'name': 'Gado-Gado',
            'description': 'Salad with peanut sauce dressing.',
            'price': '20.000',
            'imageUrl': 'https://via.placeholder.com/150',
          },
          {
            'name': 'Gado-Gado',
            'description': 'Salad with peanut sauce dressing.',
            'price': '20.000',
            'imageUrl': 'https://via.placeholder.com/150',
          },
        ],
      },
      {
        'restaurantName': 'Dessert Paradise',
        'address': 'Jl. Cinta Manis No. 11, Bandung',
        'distance': 8.7,
        'foods': [
          {
            'name': 'Chocolate Lava Cake',
            'description': 'Warm chocolate cake with melting center.',
            'price': '45.000',
            'imageUrl': 'https://via.placeholder.com/150',
          },
          {
            'name': 'Strawberry Cheesecake',
            'description': 'Cheesecake with fresh strawberry topping.',
            'price': '50.000',
            'imageUrl': 'https://via.placeholder.com/150',
          },
          {
            'name': 'Ice Cream Sundae',
            'description': 'Vanilla ice cream with chocolate syrup.',
            'price': '35.000',
            'imageUrl': 'https://via.placeholder.com/150',
          },
        ],
      },
      {
        'restaurantName': 'Japanese Delight',
        'address': 'Jl. Sakura No. 8, Yogyakarta',
        'distance': 10.5,
        'foods': [
          {
            'name': 'Sushi Platter',
            'description': 'Assorted sushi with fresh fish and rice.',
            'price': '75.000',
            'imageUrl': 'https://via.placeholder.com/150',
          },
          {
            'name': 'Ramen Spesial',
            'description': 'Hot ramen with pork and egg.',
            'price': '65.000',
            'imageUrl': 'https://via.placeholder.com/150',
          },
          {
            'name': 'Tempura Set',
            'description': 'Crispy tempura with dipping sauce.',
            'price': '50.000',
            'imageUrl': 'https://via.placeholder.com/150',
          },
        ],
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFEBE9E1),
      appBar: headerApp(context),
      bottomNavigationBar: navbar(context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Centered Food Plans Title
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Center(
                child: Text(
                  "Food Plans", // Nanti sambugin ke nama food plannya
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ),
            ),
            // List of Restaurant Cards
            ...restaurants.map((restaurant) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: RestaurantCard(
                  restaurantName:
                      restaurant['restaurantName'] ?? 'Unknown Restaurant',
                  address: restaurant['address'] ?? 'No address available',
                  distance: restaurant['distance'] ?? 0.0,
                  foods: restaurant['foods'] ?? [],
                ),
              );
            })
          ],
        ),
      ),
    );
  }
}
