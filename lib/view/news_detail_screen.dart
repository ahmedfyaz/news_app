import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

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
    final format = DateFormat("MMMM dd, yyyy");
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    DateTime dateTime = DateTime.parse(widget.newsDate);
    return Scaffold(
      appBar: AppBar(elevation: 0, backgroundColor: Colors.transparent),
      body: Stack(
        children: [
          SizedBox(
            height: height * 0.45,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(40),
              ),
              child: CachedNetworkImage(
                imageUrl: widget.newImage,
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                    Center(child: CircularProgressIndicator()),
              ),
            ),
          ),
          Container(
            height: height*.6,
            margin: EdgeInsets.only(top: height *.4),
            padding: EdgeInsets.only(top: 20,left: 20,right: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: ListView(
              children: [
                Text(widget.newsTitles,style: GoogleFonts.poppins(fontSize: 20,color: Colors.black87,fontWeight: FontWeight.w700 ),)
                ,SizedBox(height: height*.02,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(widget.source,style: GoogleFonts.poppins(fontSize: 13,color: Colors.blue,fontWeight: FontWeight.w600 ),
                    ),
                    Text(format.format(dateTime),style: GoogleFonts.poppins(fontSize: 12,color: Colors.black87,fontWeight: FontWeight.w500 )),
                  ],
                ),
            SizedBox(height: height* 0.02),
            Text(widget.description,style: GoogleFonts.poppins(fontSize: 13,color: Colors.black,fontWeight: FontWeight.w600 )),
              ],
            ),
          )
        ],
      ),
    );
  }
}
