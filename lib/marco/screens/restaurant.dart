import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: RestaurantPage(),
    debugShowCheckedModeBanner: false,
  ));
}

class RestaurantPage extends StatefulWidget {
  const RestaurantPage({Key? key}) : super(key: key);

  @override
  State<RestaurantPage> createState() => _RestaurantPageState();
}

class _RestaurantPageState extends State<RestaurantPage> {
  // Dummy data for the restaurant
  final Map<String, dynamic> restaurant = {
    'nama': 'Tengkleng Gajah, Kaliurang',
    'description': 'Tempat makanan paling enak di jogja',
    'alamat': 'Jl. Kaliurang KM 9.3, Ngaglik, Yogyakarta',
    'foto_link':
    'https://i.gojekapi.com/darkroom/gofood-indonesia/v2/images/uploads/ce17065d-f8b6-45f6-bc0d-872a05253536_Go-Biz_20220823_113519.jpeg?auto=format',
    'jamBuka': '08:00',
    'jamTutup': '22:00',
    'rating': 4.5,
  };

  // Dummy data for the foods
  final List<Map<String, dynamic>> foods = [
    {
      'nama': 'Aneka Peyek',
      'description': 'Peyek Kacang, Peyek Jingking, Peyek Udang Kecil',
      'harga': 18000,
      'foto_link':
      'https://i.gojekapi.com/darkroom/gofood-indonesia/v2/images/uploads/df40318e-0335-4c53-b383-1291dc3afde3_Go-Biz_20240124_085936.jpeg?auto=format',
    },
    {
      'nama': 'Tengkleng Gajah Original',
      'description': 'Olahan Tulang Kambing ',
      'harga': 75000,
      'foto_link':
      'https://i.gojekapi.com/darkroom/gofood-indonesia/v2/images/uploads/b5480dad-c724-49e9-a362-e646f39778cb_Go-Biz_20241017_085723.jpeg?auto=format',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEBE9E1), // Background color
      appBar: AppBar(
        backgroundColor: const Color(0xFFEBE9E1),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF0F0401)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          restaurant['nama'],
          style: const TextStyle(color: Color(0xFF0F0401)),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Restaurant Image
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFFD6536D), width: 4),
                borderRadius: BorderRadius.circular(24),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  restaurant['foto_link'],
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Restaurant Name
            Text(
              restaurant['nama'],
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Color(0xFF7C1D05),
              ),
            ),
            const SizedBox(height: 8),
            // Restaurant Address
            Text(
              restaurant['alamat'],
              style: const TextStyle(
                fontSize: 16,
                color: Color(0xFF0F0401),
              ),
            ),
            const SizedBox(height: 8),
            // Restaurant Description
            Text(
              restaurant['description'],
              style: const TextStyle(
                fontSize: 16,
                color: Color(0xFF0F0401),
              ),
            ),
            const SizedBox(height: 8),
            // Opening Hours
            Text(
              'Open: ${restaurant['jamBuka']} - ${restaurant['jamTutup']} WIB',
              style: const TextStyle(
                fontSize: 16,
                color: Color(0xFF0F0401),
              ),
            ),
            const SizedBox(height: 16),
            // Rating and Reviews
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFFD6536D), width: 2),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Reviews',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFD6536D),
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        '${restaurant['rating'] ?? 'N/A'}/5',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFD6536D),
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(
                        Icons.star,
                        color: Color(0xFFFFD401),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Foods Section
            const Text(
              'Menu',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFF7C1D05),
              ),
            ),
            const SizedBox(height: 16),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: foods.length,
              itemBuilder: (context, index) {
                final food = foods[index];
                return GestureDetector(
                  onTap: () {
                    // Show food details or modal here
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      border:
                      Border.all(color: const Color(0xFFC98809), width: 4),
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
                              food['foto_link'],
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 16),
                          // Food Details
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  food['nama'],
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF7C1D05),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  food['description'],
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF7A7A7A),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Rp${food['harga']}',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF7C1D05),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Add to Cart or Action Button
                          IconButton(
                            icon: const Icon(Icons.add_circle_outline),
                            color: const Color(0xFFE43D12),
                            onPressed: () {
                              // Handle add to cart or action
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 24),
            // Reviews Placeholder
            const Text(
              'Reviews',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFF7C1D05),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFFD6536D), width: 2),
                borderRadius: BorderRadius.circular(24),
              ),
              child: const Center(
                child: Text(
                  'No reviews yet.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF7A7A7A),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
