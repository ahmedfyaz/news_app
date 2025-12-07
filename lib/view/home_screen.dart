import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news_app/models/news_channel_headlines_model.dart';
import 'package:news_app/view/categories_screen.dart';
import 'package:news_app/view_model/news_view_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

enum FilterList {
  bbcNews,
  aryNews,
  independent,
  reuters,
  cnn,
  foxNews,
  time,
  theWashingtonPost,
  alJazeera,
  geoNews,
}
String name = "bbc-news";

class _HomeScreenState extends State<HomeScreen> {
  NewsViewModel newsViewModel = NewsViewModel();

  FilterList? selectedMenu;

  final format = DateFormat("MMMM dd, yyyy");
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width * 1;
    final height = MediaQuery.sizeOf(context).height * 1;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>CategoriesScreen()));
          },
          icon: Image.asset("assets/images/category_icon.png"),
        ),
        title: Text(
          "News",
          style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        actions: [
          PopupMenuButton(
          initialValue: selectedMenu,
          icon: Icon(Icons.more_vert,color: Colors.black),
          onSelected: (FilterList item){
            if(FilterList.bbcNews.name == item.name)
              {
                name = "bbc-news";
              }
            if(FilterList.aryNews.name == item.name)
              {
                name = "ary-news";
              }
            if(FilterList.theWashingtonPost.name == item.name)
              {
                name = "the-washington-post";
              }
            if(FilterList.reuters.name == item.name)
              {
                name = "reuters";
              }
            if(FilterList.independent.name == item.name)
              {
                name = "independent";
              }
            if(FilterList.cnn.name == item.name)
              {
                name = "cnn";
              }
            if(FilterList.foxNews.name == item.name)
              {
                name = "fox-news";
              }
            if(FilterList.time.name == item.name)
              {
                name = "time";
              }
            if(FilterList.alJazeera.name == item.name)
              {
                name = "al-jazeera-english";
              }
            setState(() {

            });
          }
          ,itemBuilder: (context)=><PopupMenuEntry<FilterList>>[
            PopupMenuItem<FilterList>(
              value: FilterList.bbcNews,
              child: Text("BBC News"),
            ),PopupMenuItem<FilterList>(
              value: FilterList.alJazeera,
              child: Text("Al Jazeera"),
            ),PopupMenuItem<FilterList>(
              value: FilterList.aryNews,
              child: Text("Ary News"),
            ),PopupMenuItem<FilterList>(
              value: FilterList.cnn,
              child: Text("CNN"),
            ),PopupMenuItem<FilterList>(
              value: FilterList.foxNews,
              child: Text("Fox News"),
            ),PopupMenuItem<FilterList>(
              value: FilterList.independent,
              child: Text("Independent"),
            ),PopupMenuItem<FilterList>(
              value: FilterList.reuters,
              child: Text("Reuters"),
            ),PopupMenuItem<FilterList>(
              value: FilterList.theWashingtonPost,
              child: Text("The Washington Post"),
            ),PopupMenuItem<FilterList>(
              value: FilterList.time,
              child: Text("Time"),
            ),
          ])
        ],
      ),
      body: ListView(
        children: [
          SizedBox(
            height: height * .55,
            width: width,
            child: FutureBuilder<NewsChannelHeadlinesModel>(
              future: newsViewModel.fetchNewChannelHeadlinesApi(name),
              builder: (BuildContext context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return SpinKitFadingCircle(
                    size: 50,
                    color: Color(0xFFF6794D),
                  );
                } else {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data!.articles!.length,
                    itemBuilder: (context, index) {
                      DateTime dateTime = DateTime.parse(
                        snapshot.data!.articles![index].publishedAt.toString(),
                      );
                      return SizedBox(
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              height: height * .6,
                              width: width * .9,
                              padding: EdgeInsets.symmetric(
                                horizontal: height * 0.02,
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: CachedNetworkImage(
                                  imageUrl: snapshot
                                      .data!
                                      .articles![index]
                                      .urlToImage
                                      .toString(),
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) =>
                                      SpinKitFadingCircle(
                                        color: Colors.amber,
                                        size: 50,
                                      ),
                                  errorWidget: (context, url, error) => Icon(
                                    Icons.warning,
                                    color: Colors.redAccent,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 20,
                              child: Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Container(
                                  height: height * .22,
                                  alignment: Alignment.bottomCenter,
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: width * 0.7,
                                          child: Text(
                                            snapshot
                                                .data!
                                                .articles![index]
                                                .title
                                                .toString(),
                                            style: GoogleFonts.poppins(
                                              fontSize: 17,
                                              fontWeight: .w700,
                                            ),
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        Spacer(),
                                        Container(
                                          width: width * 0.7,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                snapshot
                                                    .data!
                                                    .articles![index]
                                                    .source!
                                                    .name
                                                    .toString(),
                                                style: GoogleFonts.poppins(
                                                  fontSize: 13,
                                                  fontWeight: .w600,
                                                  color: Colors.blue,
                                                ),
                                                maxLines: 3,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              Text(
                                                format.format(dateTime),
                                                style: GoogleFonts.poppins(
                                                  fontSize: 12,
                                                  fontWeight: .w500,
                                                ),
                                                maxLines: 3,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
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
