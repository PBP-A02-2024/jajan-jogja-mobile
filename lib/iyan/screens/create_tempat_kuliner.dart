import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';

class CreateTempatKuliner extends StatefulWidget {
  const CreateTempatKuliner({super.key});

  @override
  State<CreateTempatKuliner> createState() => _CreateTempatKulinerState();
}

class _CreateTempatKulinerState extends State<CreateTempatKuliner> {
  final _formKey = GlobalKey<FormState>();
  final _namaController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _alamatController = TextEditingController();
  final _longitudeController = TextEditingController();
  final _latitudeController = TextEditingController();
  final _jamBukaController = TextEditingController();
  final _jamTutupController = TextEditingController();
  final _ratingController = TextEditingController();
  final _fotoLinkController = TextEditingController();
  final _variasiController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFC88709), // Palet warna sesuai
        title: const Center(
          child: Text(
            'Tambah Tempat Kuliner',
            style: TextStyle(
              fontFamily: 'Jockey One',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Nama
              TextFormField(
                controller: _namaController,
                decoration: InputDecoration(
                  labelText: 'Nama Tempat',
                  labelStyle: TextStyle(color: Color(0xFF7C1D04)),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF7C1D04)),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama tidak boleh kosong';
                  }
                  return null;
                },
              ),
              // Deskripsi
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: 'Deskripsi',
                  labelStyle: TextStyle(color: Color(0xFF7C1D04)),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF7C1D04)),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Deskripsi tidak boleh kosong';
                  }
                  return null;
                },
              ),
              // Alamat
              TextFormField(
                controller: _alamatController,
                decoration: InputDecoration(
                  labelText: 'Alamat',
                  labelStyle: TextStyle(color: Color(0xFF7C1D04)),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF7C1D04)),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Alamat tidak boleh kosong';
                  }
                  return null;
                },
              ),
              // Longitude
              TextFormField(
                controller: _longitudeController,
                decoration: InputDecoration(
                  labelText: 'Longitude',
                  labelStyle: TextStyle(color: Color(0xFF7C1D04)),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF7C1D04)),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Longitude tidak boleh kosong';
                  }
                  return null;
                },
              ),
              // Latitude
              TextFormField(
                controller: _latitudeController,
                decoration: InputDecoration(
                  labelText: 'Latitude',
                  labelStyle: TextStyle(color: Color(0xFF7C1D04)),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF7C1D04)),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Latitude tidak boleh kosong';
                  }
                  return null;
                },
              ),
              // Jam Buka
              TextFormField(
                controller: _jamBukaController,
                decoration: InputDecoration(
                  labelText: 'Jam Buka',
                  labelStyle: TextStyle(color: Color(0xFF7C1D04)),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF7C1D04)),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Jam buka tidak boleh kosong';
                  }
                  return null;
                },
              ),
              // Jam Tutup
              TextFormField(
                controller: _jamTutupController,
                decoration: InputDecoration(
                  labelText: 'Jam Tutup',
                  labelStyle: TextStyle(color: Color(0xFF7C1D04)),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF7C1D04)),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Jam tutup tidak boleh kosong';
                  }
                  return null;
                },
              ),
              // Rating
              TextFormField(
                controller: _ratingController,
                decoration: InputDecoration(
                  labelText: 'Rating',
                  labelStyle: TextStyle(color: Color(0xFF7C1D04)),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF7C1D04)),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Rating tidak boleh kosong';
                  }
                  return null;
                },
              ),
              // Foto Link
              TextFormField(
                controller: _fotoLinkController,
                decoration: InputDecoration(
                  labelText: 'Link Foto',
                  labelStyle: TextStyle(color: Color(0xFF7C1D04)),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF7C1D04)),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Link foto tidak boleh kosong';
                  }
                  return null;
                },
              ),
              // Variasi
              TextFormField(
                controller: _variasiController,
                decoration: InputDecoration(
                  labelText: 'Variasi Makanan',
                  labelStyle: TextStyle(color: Color(0xFF7C1D04)),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF7C1D04)),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Variasi makanan tidak boleh kosong';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFC88709), // Warna button sesuai
                  padding: EdgeInsets.symmetric(vertical: 14),
                  textStyle: TextStyle(fontSize: 16),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Lakukan aksi jika form valid
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Data berhasil disimpan')),
                    );
                    // Logic untuk menyimpan data
                  }
                },
                child: Text('Simpan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}