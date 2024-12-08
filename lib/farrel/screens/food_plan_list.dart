import 'package:flutter/material.dart';
import 'package:jajan_jogja_mobile/widgets/navbar.dart';
import 'package:jajan_jogja_mobile/widgets/header_app.dart';
import 'package:jajan_jogja_mobile/farrel/widgets/food_plan_card.dart';
import 'package:jajan_jogja_mobile/farrel/screens/food_plans.dart';

class FoodPlanList extends StatelessWidget {
  const FoodPlanList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> foodPlans = [
      {'title': 'Nama Itinerary 1', 'distance': 'Jarak Antar Lokasi: 5.4 km'},
      {'title': 'Nama Itinerary 2', 'distance': 'Jarak Antar Lokasi: 3.2 km'},
      {'title': 'Nama Itinerary 3', 'distance': 'Jarak Antar Lokasi: 8.7 km'},
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFEBE9E1),
      appBar: headerApp(context),
      bottomNavigationBar: navbar(context),
      body: Column(
        children: [
          // Page Title
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Food Plan List',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF944434), // Dark brown color
              ),
            ),
          ),
          // "Create New Food Plans" Button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ElevatedButton(
              onPressed: () {
                // Add functionality to navigate or create a new food plan
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFFA726), // Orange button color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                padding: const EdgeInsets.symmetric(vertical: 12.0),
              ),
              child: const Text(
                'Create New Food Plans',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          // Food Plan List
          Expanded(
            child: ListView.builder(
              itemCount: foodPlans.length,
              itemBuilder: (context, index) {
                final plan = foodPlans[index];
                return FoodPlanCard(
                  title: plan['title']!,
                  distance: plan['distance']!,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FoodPlans(),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
