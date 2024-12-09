import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'dart:convert'; // untuk encoding request jika perlu

class CreateTempatKuliner extends StatefulWidget {
  const CreateTempatKuliner({Key? key}) : super(key: key);

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
        title: const Center(
          child: Text('Tambah Tempat Kuliner'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Nama Tempat Kuliner
              TextFormField(
                controller: _namaController,
                decoration: InputDecoration(labelText: 'Nama Tempat'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama tempat tidak boleh kosong';
                  }
                  return null;
                },
              ),
              SizedBox(height: 8),
              // Deskripsi
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Deskripsi'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Deskripsi tidak boleh kosong';
                  }
                  return null;
                },
              ),
              SizedBox(height: 8),
              // Alamat
              TextFormField(
                controller: _alamatController,
                decoration: InputDecoration(labelText: 'Alamat'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Alamat tidak boleh kosong';
                  }
                  return null;
                },
              ),
              SizedBox(height: 8),
              // Longitude
              TextFormField(
                controller: _longitudeController,
                decoration: InputDecoration(labelText: 'Longitude'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Longitude tidak boleh kosong';
                  }
                  return null;
                },
              ),
              SizedBox(height: 8),
              // Latitude
              TextFormField(
                controller: _latitudeController,
                decoration: InputDecoration(labelText: 'Latitude'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Latitude tidak boleh kosong';
                  }
                  return null;
                },
              ),
              SizedBox(height: 8),
              // Jam Buka
              TextFormField(
                controller: _jamBukaController,
                decoration: InputDecoration(labelText: 'Jam Buka'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Jam buka tidak boleh kosong';
                  }
                  return null;
                },
              ),
              SizedBox(height: 8),
              // Jam Tutup
              TextFormField(
                controller: _jamTutupController,
                decoration: InputDecoration(labelText: 'Jam Tutup'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Jam tutup tidak boleh kosong';
                  }
                  return null;
                },
              ),
              SizedBox(height: 8),
              // Rating
              TextFormField(
                controller: _ratingController,
                decoration: InputDecoration(labelText: 'Rating'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Rating tidak boleh kosong';
                  }
                  return null;
                },
              ),
              SizedBox(height: 8),
              // Foto Link
              TextFormField(
                controller: _fotoLinkController,
                decoration: InputDecoration(labelText: 'Foto Link'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Foto link tidak boleh kosong';
                  }
                  return null;
                },
              ),
              SizedBox(height: 8),
              // Variasi Menu
              TextFormField(
                controller: _variasiController,
                decoration: InputDecoration(labelText: 'Variasi Menu'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Variasi menu tidak boleh kosong';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              // Tombol Submit
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    // Kirim data ke server atau proses lainnya
                    print("Tempat Kuliner Baru: ${_namaController.text}");
                    // Tambahkan pengiriman data atau API call di sini
                  }
                },
                child: Text('Tambah'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
