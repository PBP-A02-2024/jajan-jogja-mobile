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
  int _longitudeController = 0; // integer for longitude
  int _latitudeController = 0; // integer for latitude
  TimeOfDay _jamBukaController = TimeOfDay(hour: 9, minute: 0); // Time input for jam buka
  TimeOfDay _jamTutupController = TimeOfDay(hour: 21, minute: 0); // Time input for jam tutup
  String _fotoLinkController = '';
  List<int> _variasiController = []; // List for variations
  List<String> _variasiOptions = []; // Placeholder for variations options
  
  // Function to pick time
  Future<void> _selectTime(BuildContext context, bool isBuka) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: isBuka ? _jamBukaController : _jamTutupController,
    );
    if (picked != null && picked != (isBuka ? _jamBukaController : _jamTutupController)) {
      setState(() {
        if (isBuka) {
          _jamBukaController = picked;
        } else {
          _jamTutupController = picked;
        }
      });
    }
  }

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
              _buildNumberField(
                hintText: "Longitude",
                labelText: "Longitude",
                onChanged: (value) => setState(() {
                  _longitudeController = int.tryParse(value!) ?? 0;
                }),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Longitude tidak boleh kosong!";
                  }
                  return null;
                },
              ),
              _buildNumberField(
                hintText: "Latitude",
                labelText: "Latitude",
                onChanged: (value) => setState(() {
                  _latitudeController = int.tryParse(value!) ?? 0;
                }),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Latitude tidak boleh kosong!";
                  }
                  return null;
                },
              ),
              _buildTimePickerField(
                hintText: "Jam Buka",
                labelText: "Jam Buka",
                time: _jamBukaController,
                onTap: () => _selectTime(context, true),
              ),
              _buildTimePickerField(
                hintText: "Jam Tutup",
                labelText: "Jam Tutup",
                time: _jamTutupController,
                onTap: () => _selectTime(context, false),
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
              _buildVariationDropdown(),
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
                            "jam_buka": _jamBukaController.format(context),
                            "jam_tutup": _jamTutupController.format(context),
                            "foto_link": _fotoLinkController,
                            "variasi": _variasiController,
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

  Padding _buildNumberField({
    required String hintText,
    required String labelText,
    required Function(String?) onChanged,
    required String? Function(String?) validator,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        keyboardType: TextInputType.number,
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

  Padding _buildTimePickerField({
    required String hintText,
    required String labelText,
    required TimeOfDay time,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: onTap,
        child: AbsorbPointer(
          child: TextFormField(
            decoration: InputDecoration(
              hintText: hintText,
              labelText: labelText,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
            controller: TextEditingController(text: time.format(context)),
          ),
        ),
      ),
    );
  }

  Padding _buildVariationDropdown() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DropdownButtonFormField<int>(
        decoration: InputDecoration(
          labelText: "Variasi",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
        value: _variasiController.isEmpty ? null : _variasiController.first,
        onChanged: (int? newValue) {
          setState(() {
            if (newValue != null) {
              _variasiController = [newValue];
            }
          });
        },
        items: _variasiOptions.map((variasi) {
          return DropdownMenuItem(
            value: int.parse(variasi),
            child: Text(variasi),
          );
        }).toList(),
      ),
    );
  }
}
