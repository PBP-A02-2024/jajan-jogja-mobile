import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:intl/intl.dart';
import 'package:jajan_jogja_mobile/zoya/models/community_forum_entry.dart';
import '../../widgets/navbar.dart';

void main() {
  runApp(MaterialApp(
    home: LandingPage(),
    debugShowCheckedModeBanner: false,
  ));
}

class LandingPage extends StatelessWidget {
  final List<String> carouselImages = [
    'https://images.unsplash.com/photo-1524985069026-dd778a71c7b4',
    'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4',
    'https://images.unsplash.com/photo-1482049016688-2d3e1b311543',
  ];

  final List<CommunityForumEntry> communityEntries = [
    CommunityForumEntry(
      model: "community.forum",
      pk: "1",
      fields: Fields(
        user: 1,
        time: DateTime.now().subtract(const Duration(hours: 5)),
        comment: "What's the best street food in Jogja?",
      ),
    ),
    CommunityForumEntry(
      model: "community.forum",
      pk: "2",
      fields: Fields(
        user: 2,
        time: DateTime.now().subtract(const Duration(hours: 12)),
        comment: "Any recommendations for local coffee shops?",
      ),
    ),
  ];

  LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jajan Jogja'),
        backgroundColor: const Color(0xFFE43D12),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CarouselSlider(
                options: CarouselOptions(
                  height: 200.0,
                  autoPlay: true,
                  enlargeCenterPage: true,
                ),
                items: carouselImages.map((image) {
                  return Builder(
                    builder: (BuildContext context) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          image,
                          fit: BoxFit.cover,
                          width: MediaQuery.of(context).size.width,
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),
              // Header Text
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
              // Community Forum
              const Text(
                "Community Forum",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFE43D12),
                ),
              ),
              const SizedBox(height: 12),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: communityEntries.length,
                itemBuilder: (context, index) {
                  final entry = communityEntries[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "User ${entry.fields.user}",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF7C1D05),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            DateFormat('yyyy-MM-dd HH:mm').format(entry.fields.time),
                            style: const TextStyle(
                              fontSize: 12,
                              color: Color(0xFF7A7A7A),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            entry.fields.comment,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  );
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
