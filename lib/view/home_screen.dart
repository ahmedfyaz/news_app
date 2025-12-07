import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news_app/models/categories_news_model.dart';
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

class _HomeScreenState extends State<HomeScreen> {
  NewsViewModel newsViewModel = NewsViewModel();

  FilterList? selectedMenu;

  final format = DateFormat("MMMM dd, yyyy");
  String name = "bbc-news";

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width * 1;
    final height = MediaQuery.sizeOf(context).height * 1;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const CategoriesScreen()));
          },
          icon: Image.asset("assets/images/category_icon.png"),
        ),
        title: Text(
          "News",
          style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        actions: [
          PopupMenuButton<FilterList>(
              initialValue: selectedMenu,
              icon: const Icon(Icons.more_vert, color: Colors.black),
              onSelected: (FilterList item) {
                if (FilterList.bbcNews.name == item.name) {
                  name = "bbc-news";
                }
                if (FilterList.aryNews.name == item.name) {
                  name = "ary-news";
                }
                if (FilterList.theWashingtonPost.name == item.name) {
                  name = "the-washington-post";
                }
                if (FilterList.reuters.name == item.name) {
                  name = "reuters";
                }
                if (FilterList.independent.name == item.name) {
                  name = "independent";
                }
                if (FilterList.cnn.name == item.name) {
                  name = "cnn";
                }
                if (FilterList.foxNews.name == item.name) {
                  name = "fox-news";
                }
                if (FilterList.time.name == item.name) {
                  name = "time";
                }
                if (FilterList.alJazeera.name == item.name) {
                  name = "al-jazeera-english";
                }
                setState(() {});
              },
              itemBuilder: (context) => <PopupMenuEntry<FilterList>>[
                    const PopupMenuItem<FilterList>(
                      value: FilterList.bbcNews,
                      child: Text("BBC News"),
                    ),
                    const PopupMenuItem<FilterList>(
                      value: FilterList.alJazeera,
                      child: Text("Al Jazeera"),
                    ),
                    const PopupMenuItem<FilterList>(
                      value: FilterList.aryNews,
                      child: Text("Ary News"),
                    ),
                    const PopupMenuItem<FilterList>(
                      value: FilterList.cnn,
                      child: Text("CNN"),
                    ),
                    const PopupMenuItem<FilterList>(
                      value: FilterList.foxNews,
                      child: Text("Fox News"),
                    ),
                    const PopupMenuItem<FilterList>(
                      value: FilterList.independent,
                      child: Text("Independent"),
                    ),
                    const PopupMenuItem<FilterList>(
                      value: FilterList.reuters,
                      child: Text("Reuters"),
                    ),
                    const PopupMenuItem<FilterList>(
                      value: FilterList.theWashingtonPost,
                      child: Text("The Washington Post"),
                    ),
                    const PopupMenuItem<FilterList>(
                      value: FilterList.time,
                      child: Text("Time"),
                    ),
                  ])
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: height * .55,
            width: width,
            child: FutureBuilder<NewsChannelHeadlinesModel>(
              future: newsViewModel.fetchNewChannelHeadlinesApi(name),
              builder: (BuildContext context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: SpinKitFadingCircle(
                      size: 50,
                      color: Color(0xFFF6794D),
                    ),
                  );
                } else if (snapshot.hasData &&
                    snapshot.data!.articles != null &&
                    snapshot.data!.articles!.isNotEmpty) {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data!.articles!.length,
                    itemBuilder: (context, index) {
                      var article = snapshot.data!.articles![index];
                      DateTime? dateTime;
                      if (article.publishedAt != null) {
                        dateTime = DateTime.parse(article.publishedAt!);
                      }

                      return SizedBox(
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            if (article.urlToImage != null)
                              Container(
                                height: height * .6,
                                width: width * .9,
                                padding: EdgeInsets.symmetric(
                                  horizontal: height * 0.02,
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: CachedNetworkImage(
                                    imageUrl: article.urlToImage!,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) =>
                                        const SpinKitFadingCircle(
                                      color: Colors.amber,
                                      size: 50,
                                    ),
                                    errorWidget: (context, url, error) =>
                                        const Icon(
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
                                        if (article.title != null)
                                          Container(
                                            width: width * 0.7,
                                            child: Text(
                                              article.title!,
                                              style: GoogleFonts.poppins(
                                                fontSize: 17,
                                                fontWeight: FontWeight.w700,
                                              ),
                                              maxLines: 3,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        const Spacer(),
                                        if (dateTime != null)
                                          Container(
                                            width: width * 0.7,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  article.source?.name ??
                                                      'Unknown',
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 13,
                                                    fontWeight:
                                                        FontWeight.w600,
                                                    color: Colors.blue,
                                                  ),
                                                  maxLines: 3,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                Text(
                                                  format.format(dateTime),
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w500,
                                                  ),
                                                  maxLines: 3,
                                                  overflow:
                                                      TextOverflow.ellipsis,
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
                } else {
                  return const Center(
                    child: Text("No news articles found."),
                  );
                }
              },
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FutureBuilder<CategoriesNewsModel>(
                future: newsViewModel.fetchCategoriesNewsApi("General"),
                builder: (BuildContext context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: SpinKitFadingCircle(
                        size: 50,
                        color: Color(0xFFF6794D),
                      ),
                    );
                  } else if (snapshot.hasData &&
                      snapshot.data!.articles != null &&
                      snapshot.data!.articles!.isNotEmpty) {
                    return ListView.builder(
                      itemCount: snapshot.data!.articles!.length,
                      itemBuilder: (context, index) {
                        var article = snapshot.data!.articles![index];
                        DateTime? dateTime;
                        if (article.publishedAt != null) {
                          dateTime = DateTime.parse(article.publishedAt!);
                        }

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 15),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Row(
                              children: [
                                if (article.urlToImage != null)
                                  ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(15),
                                      bottomLeft: Radius.circular(15),
                                    ),
                                    child: CachedNetworkImage(
                                      imageUrl: article.urlToImage!,
                                      fit: BoxFit.cover,
                                      height: height * 0.15,
                                      width: width * 0.3,
                                      placeholder: (context, url) =>
                                          const Center(
                                        child: SpinKitFadingCircle(
                                          color: Colors.amber,
                                          size: 40,
                                        ),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error_outline,
                                              color: Colors.red),
                                    ),
                                  ),
                                Expanded(
                                  child: Container(
                                    height: height * 0.15,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        if (article.title != null)
                                          Text(
                                            article.title!,
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.poppins(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        const Spacer(),
                                        if (dateTime != null)
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                article.source?.name ??
                                                    "Unknown",
                                                style: GoogleFonts.poppins(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.blue,
                                                ),
                                              ),
                                              Text(
                                                format.format(dateTime),
                                                style: GoogleFonts.poppins(
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ],
                                          ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return const Center(
                      child: Text("No news articles found."),
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
