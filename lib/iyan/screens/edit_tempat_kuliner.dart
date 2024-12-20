import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class EditTempatKuliner extends StatefulWidget {
  final int id; // ID tempat kuliner yang akan diedit
  const EditTempatKuliner({super.key, required this.id});

  @override
  State<EditTempatKuliner> createState() => _EditTempatKulinerState();
}

class _EditTempatKulinerState extends State<EditTempatKuliner> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _namaController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _alamatController = TextEditingController();
  TextEditingController _fotoLinkController = TextEditingController();
  int _longitudeController = 0;
  int _latitudeController = 0;
  TimeOfDay _jamBukaController = TimeOfDay(hour: 9, minute: 0);
  TimeOfDay _jamTutupController = TimeOfDay(hour: 21, minute: 0);
  List<int> _variasiController = [];
  List<String> _variasiOptions = ["Variasi 1", "Variasi 2", "Variasi 3"]; // contoh variasi

  // Fungsi untuk mengambil data tempat kuliner dari API berdasarkan ID
  Future<void> _getTempatKuliner() async {
    final request = context.watch<CookieRequest>();
    final response = await request.get(
      'http://127.0.0.1:8000/tempat-kuliner/${widget.id}/', // endpoint untuk mengambil data tempat kuliner berdasarkan ID
    );
    if (response['status'] == 'success') {
      setState(() {
        // Mengisi data yang ada ke dalam controller
        _namaController.text = response['data']['nama'];
        _descriptionController.text = response['data']['description'];
        _alamatController.text = response['data']['alamat'];
        _longitudeController = response['data']['longitude'];
        _latitudeController = response['data']['latitude'];
        _fotoLinkController.text = response['data']['foto_link'];
        _variasiController = List<int>.from(response['data']['variasi']);
        _jamBukaController = TimeOfDay(
          hour: int.parse(response['data']['jam_buka'].split(':')[0]),
          minute: int.parse(response['data']['jam_buka'].split(':')[1]),
        );
        _jamTutupController = TimeOfDay(
          hour: int.parse(response['data']['jam_tutup'].split(':')[0]),
          minute: int.parse(response['data']['jam_tutup'].split(':')[1]),
        );
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _getTempatKuliner(); // Ambil data ketika halaman dimuat
  }

  // Fungsi untuk memperbarui tempat kuliner
  Future<void> _updateTempatKuliner() async {
    final request = context.watch<CookieRequest>();
    final response = await request.postJson(
      'http://127.0.0.1:8000/tempat-kuliner/${widget.id}/', // endpoint untuk update data tempat kuliner
      jsonEncode({
        "nama": _namaController.text,
        "description": _descriptionController.text,
        "alamat": _alamatController.text,
        "longitude": _longitudeController,
        "latitude": _latitudeController,
        "jam_buka": _jamBukaController.format(context),
        "jam_tutup": _jamTutupController.format(context),
        "foto_link": _fotoLinkController.text,
        "variasi": _variasiController,
      }),
    );
    if (response['status'] == 'success') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Tempat kuliner berhasil diperbarui!")),
      );
      Navigator.pop(context); // Kembali ke halaman sebelumnya
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Terjadi kesalahan, coba lagi.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Edit Tempat Kuliner')),
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
                controller: _namaController,
                onChanged: (value) => setState(() {
                  _namaController.text = value!;
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
                controller: _descriptionController,
                onChanged: (value) => setState(() {
                  _descriptionController.text = value!;
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
                controller: _alamatController,
                onChanged: (value) => setState(() {
                  _alamatController.text = value!;
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
                initialValue: _longitudeController.toString(),
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
                initialValue: _latitudeController.toString(),
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
                controller: _fotoLinkController,
                onChanged: (value) => setState(() {
                  _fotoLinkController.text = value!;
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
                        await _updateTempatKuliner();
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
    required TextEditingController controller,
    required Function(String?) onChanged,
    required String? Function(String?) validator,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
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
    required String initialValue,
    required Function(String?) onChanged,
    required String? Function(String?) validator,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        initialValue: initialValue,
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

  Future<void> _selectTime(BuildContext context, bool isOpenTime) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: isOpenTime ? _jamBukaController : _jamTutupController,
    );
    if (pickedTime != null) {
      setState(() {
        if (isOpenTime) {
          _jamBukaController = pickedTime;
        } else {
          _jamTutupController = pickedTime;
        }
      });
    }
  }

  Padding _buildVariationDropdown() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DropdownButtonFormField<int>(
        value: _variasiController.isNotEmpty ? _variasiController[0] : null,
        onChanged: (value) {
          setState(() {
            _variasiController = value != null ? [value] : [];
          });
        },
        decoration: InputDecoration(
          labelText: "Pilih Variasi",
          border: OutlineInputBorder(),
        ),
        items: _variasiOptions
            .map((variasi) => DropdownMenuItem<int>(
                  value: int.parse(variasi),
                  child: Text(variasi),
                ))
            .toList(),
      ),
    );
  }
}
