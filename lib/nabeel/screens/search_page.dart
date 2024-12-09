import 'package:flutter/material.dart';
import 'package:jajan_jogja_mobile/iyan/models/resto.dart';
import 'package:jajan_jogja_mobile/nabeel/widgets/tempatkuliner_card.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:jajan_jogja_mobile/nabeel/models/search.dart';
import 'package:jajan_jogja_mobile/widgets/header_app.dart';
import 'package:jajan_jogja_mobile/widgets/navbar.dart';

class SearchPage extends StatefulWidget {
  final BuildContext context;
  const SearchPage({super.key, required this.context});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  Future<List<Search>> fetchSearch(CookieRequest request) async {
    final response = await request.get('http://localhost:8000/search/show-search-history/');
    List<Search> listSearch = [];
    for (var d in response) {
      if (d != null) {
        listSearch.add(Search.fromJson(d));
      }
    }
    return listSearch;
  }

  Future<List<TempatKuliner>> fetchResto(CookieRequest request) async {
    final response = await request.get('http://localhost:8000/json-tempat/');
    List<TempatKuliner> listResto = [];
    for (var d in response) {
      if (d != null) {
        listResto.add(TempatKuliner.fromJson(d));
      }
    }
    return listResto;
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      appBar: headerApp(context),
      bottomNavigationBar: navbar(context, "search"),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: Column(
                children: [
                  Text(
                    "Discover Jogja's Best Eats",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Quickly search resto by name, category, or keyword.",
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<TempatKuliner>>(
              future: fetchResto(request),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No data available'));
                } else {
                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 8.0,
                    ),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final resto = snapshot.data![index];
                      return TempatKulinerCard(tempatKuliner: resto);
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}