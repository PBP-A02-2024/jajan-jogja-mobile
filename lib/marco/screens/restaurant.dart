import 'package:flutter/material.dart';
import 'package:jajan_jogja_mobile/marco/models/makanan.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

import '../../iyan/models/resto.dart';
import '../../widgets/navbar.dart';
import 'package:jajan_jogja_mobile/vander/widgets/review_list_widget.dart';
import 'package:jajan_jogja_mobile/vander/screens/review_form.dart';


class RestaurantPage extends StatefulWidget {
  final String idTempatKuliner;

  const RestaurantPage({required this.idTempatKuliner, super.key});

  @override
  State<RestaurantPage> createState() => _RestaurantPageState();
}

class _RestaurantPageState extends State<RestaurantPage> {
  // Tambahkan state variables untuk menyimpan data yang diambil dari API
  TempatKuliner? restaurant;
  List<Makanan> makananList = [];
  bool isLoading = true;
  String? errorMessage;

  // Fungsi untuk mengambil kedua data secara bersamaan
  Future<Map<String, dynamic>> fetchAllData(CookieRequest request) async {
    try {
      final responses = await Future.wait([
        fetchMakanan(request),
        fetchTempatKuliner(request),
      ]);

      return {
        'makananList': responses[0],
        'restaurant': responses[1],
      };
    } catch (e) {
      throw Exception('Failed to load data: $e');
    }
  }

  Future<List<Makanan>> fetchMakanan(CookieRequest request) async {
    final responseMakanan = await request.get('http://127.0.0.1:8000/restaurant/get_makanan_json/${widget.idTempatKuliner}/');

    // Melakukan decode response menjadi bentuk json
    var dataMakanan = responseMakanan;

    // Melakukan konversi data json menjadi object
    List<Makanan> listProduct = [];
    for (var d in dataMakanan) {
      if (d != null) {
        listProduct.add(Makanan.fromJson(d));
      }
    }
    return listProduct;
  }

  Future<TempatKuliner> fetchTempatKuliner(CookieRequest request) async {
    final responseRestaurant = await request.get('http://127.0.0.1:8000/restaurant/get_restoran_json/${widget.idTempatKuliner}/');

    // Melakukan decode response menjadi bentuk json
    var dataRestaurant = responseRestaurant;

    // Melakukan konversi data json menjadi object
    // Asumsikan responseRestaurant adalah List<dynamic> dengan satu objek TempatKuliner
    List<TempatKuliner> listProduct = [];
    for (var d in dataRestaurant) {
      if (d != null) {
        listProduct.add(TempatKuliner.fromJson(d));
      }
    }

    if (listProduct.isNotEmpty) {
      return listProduct.first;
    } else {
      throw Exception('No restaurant data found');
    }
  }

  final tempatKulinerId = "2dbf8eaa-7533-4047-b420-93b496cd4ca0";
  final tempatKulinerNama = "NamakuBebas";
  int _reviewListKey = 0;

  void _goToAddReview() async {
    // Navigate to ReviewEntryFormPage and wait for the result
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ReviewEntryFormPage(
          tempatKulinerId: tempatKulinerId,
          tempatKulinerNama: tempatKulinerNama,
        ),
      ),
    );

    // If a new review was added, trigger a refresh
    if (result == true) {
      setState(() {
        // Increment a key or trigger a rebuild in another way
        _reviewListKey++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

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
        title: const Text(
          'Restaurant',
          style: TextStyle(color: Color(0xFF0F0401)),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: fetchAllData(request),
        builder: (context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Tampilkan loading indicator saat data sedang diambil
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            // Tampilkan error message jika ada
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: const TextStyle(color: Colors.red, fontSize: 18),
              ),
            );
          } else if (!snapshot.hasData) {
            // Tampilkan pesan jika tidak ada data
            return const Center(
              child: Text(
                'No data available',
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
            );
          } else {
            // Ambil data dari snapshot
            restaurant = snapshot.data!['restaurant'] as TempatKuliner;
            makananList = snapshot.data!['makananList'] as List<Makanan>;


            return SingleChildScrollView(
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
                        restaurant?.fields.fotoLink ?? '',
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Center(child: Text('Image not available'));
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Restaurant Name
                  Text(
                    restaurant?.fields.nama ?? 'Nama Restaurant',
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF7C1D05),
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Restaurant Address
                  Text(
                    restaurant?.fields.alamat ?? 'Alamat tidak tersedia',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Color(0xFF0F0401),
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Restaurant Description
                  Text(
                    restaurant?.fields.description ?? 'Deskripsi tidak tersedia',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Color(0xFF0F0401),
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Opening Hours
                  Text(
                    'Open: ${restaurant?.fields.jamBuka ?? 'N/A'} - ${restaurant?.fields.jamTutup ?? 'N/A'} WIB',
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
                              '${restaurant?.fields.rating ?? 'N/A'}/5',
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
                  // Tampilkan list makanan yang diambil dari API
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: makananList.length,
                    itemBuilder: (context, index) {
                      final food = makananList[index];
                      return GestureDetector(
                        onTap: () {
                          // Tampilkan detail makanan atau modal di sini
                        },
                        child: Container(
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
                                // Add to Cart or Action Button
                                IconButton(
                                  icon: const Icon(Icons.add_circle_outline),
                                  color: const Color(0xFFE43D12),
                                  onPressed: () {
                                    // Handle add to cart atau aksi lainnya
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
                  IconButton(
                    onPressed: _goToAddReview,
                    icon: const Icon(Icons.add_comment),
                    color: const Color(0xFFD6536D),
                    tooltip: "Add Review",
                  ),
                  const SizedBox(height: 16),
                  ReviewsListWidget(
                    theKey: ValueKey(_reviewListKey),
                    tempatKulinerId: tempatKulinerId,
                  ),
                ],
              ),
            );
          }
        },
      ),

      bottomNavigationBar: navbar(context, ""),
    );
  }
}
