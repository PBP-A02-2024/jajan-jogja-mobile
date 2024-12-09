import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jajan_jogja_mobile/iyan/models/resto.dart';
import 'package:jajan_jogja_mobile/marco/screens/restaurant.dart';

class CardTempat extends StatelessWidget {
  final TempatKuliner tempatKuliner;

  const CardTempat(this.tempatKuliner, {super.key});

  // Fungsi untuk mengedit resto
  Future<void> editResto(BuildContext context, int restoId, String newComment) async {
    final url = Uri.parse('http://your-django-url/edit_resto/$restoId/');

    final response = await http.put(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer YOUR_JWT_TOKEN', // Sesuaikan dengan metode otentikasi yang digunakan
      },
      body: json.encode({
        'comment': newComment,
      }),
    );

    if (response.statusCode == 200) {
      // Tindakan setelah sukses edit
      final data = json.decode(response.body);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Resto successfully edited!')),
      );
      // Anda bisa memperbarui tampilan atau data di sini
    } else {
      final data = json.decode(response.body);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${data['message']}')),
      );
    }
  }

  // Fungsi untuk menghapus resto
  Future<void> deleteResto(BuildContext context, int restoId) async {
    final url = Uri.parse('http://your-django-url/delete_resto/$restoId/');

    final response = await http.delete(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer YOUR_JWT_TOKEN', // Sesuaikan dengan metode otentikasi yang digunakan
      },
    );

    if (response.statusCode == 200) {
      // Tindakan setelah sukses delete
      final data = json.decode(response.body);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Resto successfully deleted!')),
      );
      // Anda bisa memperbarui tampilan atau data di sini, misalnya pop untuk kembali
    } else {
      final data = json.decode(response.body);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${data['message']}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
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
            builder: (context) => RestaurantPage(idTempatKuliner: idTempatKuliner),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: 278,
          height: 250, // Perbesar sedikit untuk menambah tombol
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Foto resto
              Container(
                width: 278,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(40),
                  border: Border.all(color: Color(0xFFC88709), width: 2),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: Image.network(
                    fotoLink,
                    fit: BoxFit.cover,
                    width: 278,
                    height: 100,
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
              SizedBox(height: 10),
              // Row untuk tombol-tombol (Edit, Delete)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Edit button
                  ElevatedButton(
                    onPressed: () {
                      // Aksi untuk edit, misalnya tampilkan dialog atau halaman untuk edit
                      // Anda bisa mengganti ini dengan form edit komentar
                      editResto(context, idTempatKuliner, "New Comment");
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF7C1D04), // Warna tombol
                    ),
                    child: Text('Edit'),
                  ),
                  // Delete button
                  ElevatedButton(
                    onPressed: () {
                      // Aksi untuk delete
                      deleteResto(context, idTempatKuliner);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red, // Warna tombol
                    ),
                    child: Text('Delete'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
