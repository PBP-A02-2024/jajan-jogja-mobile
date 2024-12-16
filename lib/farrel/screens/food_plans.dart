import "package:flutter/material.dart";
import "package:jajan_jogja_mobile/widgets/navbar.dart";
import 'package:jajan_jogja_mobile/widgets/header_app.dart';
import 'package:jajan_jogja_mobile/farrel/widgets/restaurant_card.dart';
import 'package:jajan_jogja_mobile/farrel/models/food_plan_model.dart';
import 'package:jajan_jogja_mobile/marco/models/makanan.dart';
import 'package:jajan_jogja_mobile/iyan/models/resto.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'dart:convert';

class FoodPlans extends StatefulWidget {
  final String planId;

  const FoodPlans({
    Key? key,
    required this.planId,
  }) : super(key: key);

  @override
  State<FoodPlans> createState() => _FoodPlansState();
}

class _FoodPlansState extends State<FoodPlans> {
  late Future<Map<String, dynamic>> futurePlanDetails;

  @override
  void initState() {
    super.initState();
    final request = context.read<CookieRequest>();
    futurePlanDetails = fetchAllData(request);
  }

  Future<Map<String, dynamic>> fetchAllData(CookieRequest request) async {
    try {
      // First get the food plan details
      final response = await request.get(
          'http://127.0.0.1:8000/food_plans/food_plan_detail_json/${widget.planId}/');

      if (response is List && response.isNotEmpty) {
        final firstPlan = response[0];
        final restaurantIds =
            List<String>.from(firstPlan['fields']['tempat_kuliner']);
        final makananIds = List<String>.from(firstPlan['fields']['makanan']);

        // Fetch all restaurants and their foods
        List<TempatKuliner> restaurants = [];
        Map<String, List<Makanan>> restaurantFoods = {};

        for (String restaurantId in restaurantIds) {
          // Fetch restaurant details
          final restaurantResponse = await request.get(
              'http://127.0.0.1:8000/restaurant/get_restoran_json/$restaurantId/');
          if (restaurantResponse is List && restaurantResponse.isNotEmpty) {
            restaurants.add(TempatKuliner.fromJson(restaurantResponse[0]));
          }

          // Fetch foods for this restaurant
          final foodResponse = await request.get(
              'http://127.0.0.1:8000/restaurant/get_makanan_json/$restaurantId/');
          if (foodResponse != null) {
            List<Makanan> foods = [];
            for (var food in foodResponse) {
              if (makananIds.contains(food['pk'])) {
                foods.add(Makanan.fromJson(food));
              }
            }
            restaurantFoods[restaurantId] = foods;
          }
        }

        return {
          'foodPlan': DetailedFoodPlan(
            model: firstPlan['model'],
            pk: firstPlan['pk'],
            fields: DetailedFields(
              user: firstPlan['fields']['user'],
              nama: firstPlan['fields']['nama'],
              restaurants: restaurants,
            ),
          ),
          'restaurantFoods': restaurantFoods,
        };
      }
      throw Exception('Invalid response format');
    } catch (e) {
      throw Exception('Failed to load data: $e');
    }
  }

  // Add update title function
  Future<bool> updateTitle(CookieRequest request, String newTitle) async {
    final response = await request.post(
      'http://127.0.0.1:8000/food_plans/update_title/${widget.planId}/',
      jsonEncode({'new_title': newTitle}),
    );
    return response != null && response['success'] == "True";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEBE9E1),
      appBar: headerApp(context),
      bottomNavigationBar: navbar(context, 'food plans'),
      body: FutureBuilder<Map<String, dynamic>>(
        future: futurePlanDetails,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (snapshot.hasData) {
            final foodPlan = snapshot.data!['foodPlan'] as DetailedFoodPlan;
            final restaurantFoods =
                snapshot.data!['restaurantFoods'] as Map<String, List<Makanan>>;
            final request = context.read<CookieRequest>();

            return SingleChildScrollView(
              child: Column(
                children: [
                  // Title with Edit Icon
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(
                            foodPlan.fields.nama,
                            style: TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.edit),
                          color: Theme.of(context).colorScheme.secondary,
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                String newTitle = foodPlan.fields.nama;
                                return AlertDialog(
                                  title: const Text('Edit Food Plan Title'),
                                  content: TextField(
                                    autofocus: true,
                                    decoration: const InputDecoration(
                                      labelText: 'New Title',
                                    ),
                                    onChanged: (value) {
                                      newTitle = value;
                                    },
                                    controller: TextEditingController(
                                        text: foodPlan.fields.nama),
                                  ),
                                  actions: [
                                    TextButton(
                                      child: const Text('Cancel'),
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                    ),
                                    TextButton(
                                      child: const Text('Save'),
                                      onPressed: () async {
                                        try {
                                          final success = await updateTitle(
                                              request, newTitle);
                                          if (!context.mounted) return;

                                          if (success) {
                                            Navigator.of(context).pop();
                                            // Refresh the page
                                            setState(() {
                                              futurePlanDetails =
                                                  fetchAllData(request);
                                            });
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                  content: Text(
                                                      'Title updated successfully')),
                                            );
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                  content: Text(
                                                      'Failed to update title')),
                                            );
                                          }
                                        } catch (e) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                                content: Text('Error: $e')),
                                          );
                                        }
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
                  ),
                  // List of Restaurant Cards
                  ...foodPlan.fields.restaurants.map((restaurant) {
                    final foods = restaurantFoods[restaurant.pk] ?? [];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 16.0),
                      child: RestaurantCard(
                        restaurantName: restaurant.fields.nama,
                        address: restaurant.fields.alamat,
                        distance: 0.0,
                        foods: foods
                            .map((food) => {
                                  'name': food.fields.nama,
                                  'description': food.fields.description,
                                  'price': food.fields.harga.toString(),
                                  'imageUrl': food.fields.fotoLink,
                                })
                            .toList(),
                      ),
                    );
                  }).toList(),
                ],
              ),
            );
          }
          return const Center(child: Text('No data available'));
        },
      ),
    );
  }
}
