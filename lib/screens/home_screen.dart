import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:math';


import 'package:flutter_test_app/screens/search_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> allShows = [];
  List<dynamic> popularShows = [];
  List<dynamic> trendingShows = [];
  List<dynamic> watchAgainShows = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchShows();
  }

  Future<void> fetchShows() async {
    try {
      final response =
          await http.get(Uri.parse('https://api.tvmaze.com/search/shows?q=all'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);

       
        data.shuffle(Random());

        setState(() {
          allShows = data; // Store all the shows
          popularShows = allShows.take(4).toList(); // First 4 items
          trendingShows = allShows.skip(4).take(3).toList(); // Next 3 items
          watchAgainShows = allShows.skip(7).take(3).toList(); // Remaining 3 items
          isLoading = false;
        });
      } else {
        print('Failed to fetch data. Status code: ${response.statusCode}');
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      print('Error fetching data: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Text(
          'Netflix',
          style: TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.white),
            onPressed: () {
              // Navigate to the SearchScreen
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SearchScreen()),
              );
            },
          ),
        ],
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: Colors.red,
              ),
            )
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildCategory('Popular on Netflix', popularShows),
                  _buildCategory('Trending Now', trendingShows),
                  _buildCategory('Watch it Again', watchAgainShows),
                ],
              ),
            ),
    );
  }

  Widget _buildCategory(String title, List<dynamic> shows) {
    if (shows.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Center(
          child: Text(
            'No $title available',
            style: TextStyle(color: Colors.white70, fontSize: 16),
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: shows.length,
              itemBuilder: (context, index) {
                final show = shows[index]['show'];
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/details', arguments: show);
                  },
                  child: Container(
                    width: 140,
                    margin: EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      children: [
                        show['image'] != null
                            ? Image.network(
                                show['image']['medium'],
                                fit: BoxFit.cover,
                                width: 140,
                                height: 160,
                              )
                            : Container(
                                width: 140,
                                height: 160,
                                color: Colors.grey,
                                child: Icon(Icons.image, color: Colors.white),
                              ),
                        SizedBox(height: 5),
                        Text(
                          show['name'] ?? 'No Title',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
