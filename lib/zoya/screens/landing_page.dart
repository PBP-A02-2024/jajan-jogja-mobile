import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:intl/intl.dart';
import 'package:jajan_jogja_mobile/iyan/models/resto.dart';
import 'package:jajan_jogja_mobile/iyan/widgets/resto_card.dart';
import 'package:jajan_jogja_mobile/zoya/models/community_forum_entry.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import '../../widgets/navbar.dart';

void main() {
  runApp(MaterialApp(
    home: LandingPage(),
    debugShowCheckedModeBanner: false,
  ));
}

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  LandingPageState createState() => LandingPageState();
}

class LandingPageState extends State<LandingPage> {
  // final List<String> carouselImages = [
  //   'https://images.unsplash.com/photo-1524985069026-dd778a71c7b4',
  //   'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4',
  //   'https://images.unsplash.com/photo-1482049016688-2d3e1b311543',
  // ];

  final _commentController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Future<List<TempatKuliner>> fetchTempatKuliner(CookieRequest request) async {
    final response = await request.get('http://127.0.0.1:8000/json-tempat/');

    var data = response;

    List<TempatKuliner> listTempatKuliner = [];
    for (var d in data) {
      if (d != null) {
        listTempatKuliner.add(TempatKuliner.fromJson(d));
      }
    }
    return listTempatKuliner;
  }

  Future<List<TempatKuliner>> fetchTop5TempatKuliner(CookieRequest request) async {
    final response = await request.get('http://127.0.0.1:8000/json-tempat/');

    var data = response;

    List<TempatKuliner> listTempatKuliner = [];
    int x = 0;
    for (var d in data) {
      if (d != null) {
        if (x == 10){
          break;
        }
        listTempatKuliner.add(TempatKuliner.fromJson(d));
      }
    }
    return listTempatKuliner;
  }

  Future<String> fetchUsername(int userId, CookieRequest request) async {
    final response =
        await request.get('http://127.0.0.1:8000/json-user/$userId/');

    if (response != null) {
      var data = response;

      String username = data['username'] ?? 'Anonymous';

      return username;
    } else {
      throw Exception('Failed to load username');
    }
  }

  Future<bool> fetchUser(CookieRequest request) async {
    final response =
        await request.get('http://127.0.0.1:8000/json-current-user/');

    if (response != null) {
      var data = response;

      bool isAdmin = data['is_admin'];

      return isAdmin;
    } else {
      throw Exception('Failed to check if current user is admin');
    }
  }

  Future<List<CommunityForumEntry>> fetchCommunityForum(
      CookieRequest request) async {
    final response = await request.get('http://127.0.0.1:8000/json-forum/');

    var data = response;

    List<CommunityForumEntry> listCommunityForum = [];
    for (var d in data) {
      if (d != null) {
        listCommunityForum.add(CommunityForumEntry.fromJson(d));
      }
    }
    return listCommunityForum;
  }

  Future<void> postForumEntry(CookieRequest request) async {
    if (_formKey.currentState!.validate()) {
      final response = await request.postJson(
        'http://127.0.0.1:8000/create-flutter/',
        jsonEncode({'comment': _commentController.text}),
      );

      if (!mounted) return;

      if (response['status'] == 'success') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Forum posted successfully')),
        );
        setState(() {
          _commentController.clear();
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${response['message']}')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.center,
          child: const Text(
            'Jajan Jogja',
            style: TextStyle(
              color: Color(0xFF7C1D05),
              fontSize: 26,
            ),
          ),
        ),
        backgroundColor: const Color(0xFFEBE9E1),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FutureBuilder<List<TempatKuliner>>(
                future: fetchTop5TempatKuliner(request),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No restaurant available'));
                  } else {
                    return CarouselSlider(
                      options: CarouselOptions(
                        height: 200.0,
                        autoPlay: true,
                        enlargeCenterPage: true,
                      ),
                      items: snapshot.data!.map((image) {
                        return Builder(
                          builder: (BuildContext context) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                image.fields.fotoLink,
                                fit: BoxFit.cover,
                                width: MediaQuery.of(context).size.width,
                              ),
                            );
                          },
                        );
                      }).toList(),
                    );
                  }
                },
              ),
              const SizedBox(height: 24),
              const Text(
                "Looking for places to eat in Jogja?",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF7C1D05),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              FutureBuilder<List<TempatKuliner>>(
                future: fetchTempatKuliner(request),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No restaurant available'));
                  } else {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: snapshot.data!.map((entry) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: CardTempat(entry),
                          );
                        }).toList(),
                      ),
                    );
                  }
                },
              ),
              const SizedBox(height: 24),
              const Text(
                "Community Forum",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF7C1D05),
                ),
              ),
              const SizedBox(height: 12),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: TextFormField(
                        controller: _commentController,
                        decoration: const InputDecoration(
                          hintText: 'Write a comment...',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                        ),
                        maxLines: 3,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a comment';
                          }
                          return null;
                        },
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () => postForumEntry(request),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF7C1D05),
                      ),
                      child: const Text('Post',
                          style: TextStyle(
                            color: Color(0xFFEBE9E1),
                          )),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              FutureBuilder<List<CommunityForumEntry>>(
                future: fetchCommunityForum(request),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No forum data available'));
                  } else {
                    return Container(
                      decoration: BoxDecoration(
                        color: Color(0xFFF3F3F3),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 6,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: snapshot.data!.map((entry) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  FutureBuilder<String>(
                                    future: fetchUsername(
                                        entry.fields.user, request),
                                    builder: (context, userSnapshot) {
                                      if (userSnapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return const CircularProgressIndicator();
                                      } else if (userSnapshot.hasError) {
                                        return Text(
                                            'Error: ${userSnapshot.error}');
                                      } else {
                                        return Text(
                                          "${userSnapshot.data}",
                                          style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFFC98809),
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    entry.fields.comment,
                                    style: const TextStyle(
                                        fontSize: 14, color: Color(0xFF7A7A7A)),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Posted on ${DateFormat('yyyy-MM-dd').format(entry.fields.time)}',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Color(0xFFC98809),
                                    ),
                                  ),
                                  const Divider(color: Color(0xFFC98809)),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: navbar(context),
    );
  }
}
