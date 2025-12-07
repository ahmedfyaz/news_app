import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/models/news_channel_headlines_model.dart';
import 'package:news_app/view_model/news_view_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  NewsViewModel newsViewModel = NewsViewModel();
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width *1;
    final height = MediaQuery.sizeOf(context).height *1;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: Image.asset("assets/images/category_icon.png"),
        ),
        title: Text(
          "News",
          style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          SizedBox(
            height: height * .55,
            width: width,
            child: FutureBuilder<NewsChannelHeadlinesModel>(future: newsViewModel.fetchNewChannelHeadlinesApi(), builder: (BuildContext context, snapshot){
              if(snapshot.connectionState == ConnectionState.waiting)
                {
                  return SpinKitFadingCircle(
                    size: 50,
                    color: Color(0xFFF6794D),
                  );
                }
              else
                {
                  return Container(
                    color: Colors.grey,
                  );
                }
            }),
          )
        ],
      ),
    );
  }
}
