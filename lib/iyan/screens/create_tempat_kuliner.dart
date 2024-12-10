import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class CreateTempatKuliner extends StatefulWidget {
  const CreateTempatKuliner({super.key});

  @override
  State<CreateTempatKuliner> createState() => _CreateTempatKulinerState();
}

class _CreateTempatKulinerState extends State<CreateTempatKuliner> {
  final _formKey = GlobalKey<FormState>();
  String _namaController = '';
  String _descriptionController = '';
  String _alamatController = '';
  String _longitudeController = '';
  String _latitudeController = '';
  String _jamBukaController = '';
  String _jamTutupController = '';
  String _ratingController = '';
  String _fotoLinkController = '';
  List<int> _variasiController = [];

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Tambah Tempat Kuliner')),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTextField(
                hintText: "Nama Tempat Kuliner",
                labelText: "Nama Tempat Kuliner",
                onChanged: (value) => setState(() {
                  _namaController = value!;
                }),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Nama tempat kuliner tidak boleh kosong!";
                  }
                  return null;
                },
              ),
              _buildTextField(
                hintText: "Deskripsi Tempat Kuliner",
                labelText: "Deskripsi Tempat Kuliner",
                onChanged: (value) => setState(() {
                  _descriptionController = value!;
                }),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Deskripsi tidak boleh kosong!";
                  }
                  return null;
                },
              ),
              _buildTextField(
                hintText: "Alamat Tempat Kuliner",
                labelText: "Alamat Tempat Kuliner",
                onChanged: (value) => setState(() {
                  _alamatController = value!;
                }),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Alamat tidak boleh kosong!";
                  }
                  return null;
                },
              ),
              _buildTextField(
                hintText: "Longitude",
                labelText: "Longitude",
                onChanged: (value) => setState(() {
                  _longitudeController = value!;
                }),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Longitude tidak boleh kosong!";
                  }
                  return null;
                },
              ),
              _buildTextField(
                hintText: "Latitude",
                labelText: "Latitude",
                onChanged: (value) => setState(() {
                  _latitudeController = value!;
                }),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Latitude tidak boleh kosong!";
                  }
                  return null;
                },
              ),
              _buildTextField(
                hintText: "Jam Buka",
                labelText: "Jam Buka",
                onChanged: (value) => setState(() {
                  _jamBukaController = value!;
                }),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Jam buka tidak boleh kosong!";
                  }
                  return null;
                },
              ),
              _buildTextField(
                hintText: "Jam Tutup",
                labelText: "Jam Tutup",
                onChanged: (value) => setState(() {
                  _jamTutupController = value!;
                }),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Jam tutup tidak boleh kosong!";
                  }
                  return null;
                },
              ),
              _buildTextField(
                hintText: "Rating",
                labelText: "Rating",
                onChanged: (value) => setState(() {
                  _ratingController = value!;
                }),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Rating tidak boleh kosong!";
                  }
                  return null;
                },
              ),
              _buildTextField(
                hintText: "Foto Link",
                labelText: "Foto Link",
                onChanged: (value) => setState(() {
                  _fotoLinkController = value!;
                }),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Foto link tidak boleh kosong!";
                  }
                  return null;
                },
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        final response = await request.postJson(
                          "http://127.0.0.1:8000/create-tempat-kuliner/",
                          jsonEncode({
                            "nama": _namaController,
                            "description": _descriptionController,
                            "alamat": _alamatController,
                            "longitude": _longitudeController,
                            "latitude": _latitudeController,
                            "jam_buka": _jamBukaController,
                            "jam_tutup": _jamTutupController,
                            "rating": _ratingController,
                            "foto_link": _fotoLinkController,
                          }),
                        );
                        if (response['status'] == 'success') {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Tempat kuliner berhasil ditambahkan!")),
                          );
                          Navigator.pop(context);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Terjadi kesalahan, coba lagi.")),
                          );
                        }
                      }
                    },
                    child: const Text("Save"),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding _buildTextField({
    required String hintText,
    required String labelText,
    required Function(String?) onChanged,
    required String? Function(String?) validator,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: hintText,
          labelText: labelText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
        onChanged: onChanged,
        validator: validator,
      ),
    );
  }
}
