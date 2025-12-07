import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class NewsDetailScreen extends StatefulWidget {
  String newImage, newsTitles, newsDate, author, description, content, source;
  NewsDetailScreen({
    super.key,
    required this.newImage,
    required this.newsTitles,
    required this.newsDate,
    required this.author,
    required this.description,
    required this.content,
    required this.source,
  });

  @override
  State<NewsDetailScreen> createState() => _NewsDetailScreenState();
}

class _NewsDetailScreenState extends State<NewsDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height ;
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Stack(
        children: [
          Container(
            height: height*0.45,
            child: ClipRRect(
                child: CachedNetworkImage(imageUrl: widget.newImage,fit: BoxFit.cover,)),
          )
        ],
      ),
    );
  }
}
