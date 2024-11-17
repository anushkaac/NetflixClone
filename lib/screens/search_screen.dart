import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<dynamic> searchResults = [];
  final TextEditingController _searchController = TextEditingController();

  void searchMovies(String query) async {
    final response = await http.get(Uri.parse('https://api.tvmaze.com/search/shows?q=$query'));
    if (response.statusCode == 200) {
      setState(() {
        searchResults = json.decode(response.body);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: TextField(
          controller: _searchController,
          onSubmitted: searchMovies,
          decoration: InputDecoration(
            hintText: 'Search...',
            hintStyle: TextStyle(color: Colors.grey),
            border: InputBorder.none,
          ),
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: searchResults.isEmpty
          ? Center(
              child: Text(
                'No results found.',
                style: TextStyle(color: Colors.white),
              ),
            )
          : ListView.builder(
              itemCount: searchResults.length,
              itemBuilder: (context, index) {
                final movie = searchResults[index]['show'];
                return ListTile(
                  leading: movie['image'] != null
                      ? Image.network(
                          movie['image']['medium'],
                          width: 50,
                          fit: BoxFit.cover,
                        )
                      : Container(width: 50, height: 50, color: Colors.grey),
                  title: Text(
                    movie['name'] ?? 'No Title',
                    style: TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    movie['summary'] ?? '',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.grey),
                  ),
                );
              },
            ),
    );
  }
}
