import 'package:flutter/material.dart';
import 'package:jajan_jogja_mobile/iyan/models/resto.dart';
import 'package:jajan_jogja_mobile/iyan/screens/edit_tempat_kuliner.dart';
import 'package:jajan_jogja_mobile/marco/screens/restaurant.dart'; // Import model TempatKuliner

class CardTempat extends StatelessWidget {
  final TempatKuliner tempatKuliner;
  final bool isAdmin; // Tambahkan parameter untuk mengecek apakah pengguna admin

  const CardTempat(this.tempatKuliner, {super.key, required this.isAdmin});

  @override
  Widget build(BuildContext context) {
    // Mengambil data dari model TempatKuliner
    final idTempatKuliner = tempatKuliner.pk;
    final nama = tempatKuliner.fields.nama;
    final alamat = tempatKuliner.fields.alamat;
    final rating = double.parse(tempatKuliner.fields.rating);
    final fotoLink = tempatKuliner.fields.fotoLink;

    return GestureDetector(
      onTap: () async {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  RestaurantPage(idTempatKuliner: idTempatKuliner)),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: SingleChildScrollView( // Membungkus dengan SingleChildScrollView
            child: Container(
              padding: EdgeInsets.all(8), // Padding untuk isi container
              decoration: BoxDecoration(
                color: Colors.orange[50], // Warna latar belakang
                borderRadius: BorderRadius.circular(15), // Ujung tumpul
                border: Border.all(color: Color(0xFFC88709), width: 2), // Border dengan warna
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Foto resto
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: 90,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      border: Border.all(color: Color(0xFFC88709), width: 2),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(40),
                      child: Image.network(
                        fotoLink,
                        fit: BoxFit.cover,
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: 90,
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  // Nama tempat
                  Text(
                    nama,
                    style: TextStyle(
                      color: Color(0xFF7C1D04),
                      fontSize: 13,
                      fontFamily: 'Jockey One',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 4),
                  // Alamat
                  Text(
                    alamat,
                    style: TextStyle(
                      color: Color(0xFF7C1D04),
                      fontSize: 9.94,
                      fontFamily: 'Jockey One',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 8),
                  // Rating
                  Row(
                    children: [
                      Text(
                        '$rating/5',
                        style: TextStyle(
                          color: Color(0xFF7C1D04),
                          fontSize: 10,
                          fontFamily: 'Jockey One',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(width: 5),
                      Icon(
                        Icons.star,
                        color: Color(0xFFEFB11D),
                        size: 18,
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  // Tambahkan tombol edit & delete jika pengguna admin
                  if (isAdmin)
                    Row(
                      children: [
                        // edit
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                                vertical: 4, horizontal: 8), // Menyesuaikan padding
                            backgroundColor:
                                Color.fromARGB(255, 237, 178, 60), // Menyesuaikan warna
                          ),                  
                          onPressed: () {
                            // Navigasi ke halaman CreateTempatKuliner
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditTempatKuliner(idTempatKuliner: '0', id: 0,),
                              ),
                            );
                          },
                          child: Text(
                            'Edit',
                            style: TextStyle(
                              fontSize: 10,
                              color: Color.fromARGB(255, 151, 103, 0),
                            ),
                          ),
                        ),
                        SizedBox(width: 8),
                        // delete
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                                vertical: 4, horizontal: 8), // Menyesuaikan padding
                            backgroundColor: Color.fromARGB(255, 230, 58, 15),
                          ),
                          onPressed: () {
                            // Hapus data
                          },
                          child: Text(
                            'Delete',
                            style: TextStyle(
                              fontSize: 10,
                              color: Color.fromARGB(255, 56, 40, 4),
                            ),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
