import 'package:flutter/material.dart';

class MovieListTile extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String summary;
  final VoidCallback onTap;

  MovieListTile({required this.imageUrl, required this.title, required this.summary, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(imageUrl),
      title: Text(title),
      subtitle: Text(summary, maxLines: 2, overflow: TextOverflow.ellipsis),
      onTap: onTap,
    );
  }
}
