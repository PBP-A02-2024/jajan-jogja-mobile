import 'package:flutter/material.dart';
import 'package:jajan_jogja_mobile/iyan/screens/create_tempat_kuliner.dart';

class CreateTempat extends StatelessWidget {
  final bool isAdmin; // Parameter untuk mengecek apakah pengguna adalah admin

  const CreateTempat({super.key, required this.isAdmin});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tempat Kuliner"),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Text(
          "Add Tempat Kuliner",
          style: TextStyle(fontSize: 18),
        ),
      ),
      floatingActionButton: isAdmin
          ? FloatingActionButton(
              onPressed: () {
                // Navigasi ke halaman CreateTempatKuliner
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CreateTempatKuliner(),
                  ),
                );
              },
              backgroundColor: const Color.fromARGB(255, 237, 178, 60),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.add,
                    color: Color.fromARGB(255, 151, 103, 0),
                    size: 24,
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Restoran',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color.fromARGB(255, 151, 103, 0),
                    ),
                  ),
                ],
              ),
            )
          : null, // Tidak tampilkan tombol jika bukan admin
    );
  }
}
