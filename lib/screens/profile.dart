import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jajan_jogja_mobile/widgets/header_app.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import '../../widgets/navbar.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  void saveProfile() async {
    if (_formKey.currentState!.validate()) {
      final request = context.read<CookieRequest>();
      try {
        final response = await request.postJson(
            'http://127.0.0.1:8000/auth/profile-flutter/',
            jsonEncode({
              'username': _nameController.text,
              'email': _emailController.text,
            }));

        if (mounted) {
          if (response['status'] == 'success') {
            setState(() {
              _isEditing = false;
            });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Profile updated successfully!")),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content:
                      Text("Failed to update profile: ${response['message']}")),
            );
          }
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error saving profile: $e')),
          );
        }
      }
    }
  }

  void cancelEdit() async {
    setState(() {
      _isEditing = false;
    });

    await _fetchData();
  }

  Future<void> _fetchData() async {
    final request = context.read<CookieRequest>();
    try {
      final response =
          await request.get('http://127.0.0.1:8000/json-current-user/');

      if (mounted && response != null) {
        setState(() {
          _nameController.text = response['username'] ?? '';
          _emailController.text = response['email'] ?? '';
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error fetching user data: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: headerApp(context),
      body: Center(
        child: Container(
          width: 320,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(color: Color(0xFF7C1D05), width: 2),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 16),
                TextFormField(
                  controller: _nameController,
                  enabled: _isEditing,
                  decoration: InputDecoration(
                    labelText: "Name",
                    labelStyle: TextStyle(color: Color(0xFF7C1D05)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide:
                          BorderSide(color: Color(0xFF7C1D05), width: 2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide:
                          BorderSide(color: Color(0xFFC98809), width: 2),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _emailController,
                  enabled: _isEditing,
                  decoration: InputDecoration(
                    labelText: "Email",
                    labelStyle: TextStyle(color: Color(0xFF7C1D05)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide:
                          BorderSide(color: Color(0xFF7C1D05), width: 2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide:
                          BorderSide(color: Color(0xFFC98809), width: 2),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Email cannot be empty";
                    }
                    // Regex to validate email format
                    String pattern = r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+';
                    if (!RegExp(pattern).hasMatch(value)) {
                      return "Enter a valid email address";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: _isEditing
                      ? [
                          ElevatedButton(
                            onPressed: cancelEdit,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFFE43D12),
                            ),
                            child: Text("Cancel",
                                style: TextStyle(color: Colors.white)),
                          ),
                          ElevatedButton(
                            onPressed: saveProfile,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFC98809),
                            ),
                            child: Text("Save",
                                style: TextStyle(color: Colors.white)),
                          ),
                        ]
                      : [
                          ElevatedButton(
                            onPressed: () => setState(() => _isEditing = true),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFC98809),
                            ),
                            child: Text("Edit",
                                style: TextStyle(color: Colors.white)),
                          ),
                        ],
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: navbar(context, "profile"),
    );
  }
}
