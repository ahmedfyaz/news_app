import "dart:convert";
import "package:flutter/foundation.dart";
import "package:http/http.dart" as http;
import "package:news_app/models/categories_news_model.dart";
import "package:news_app/models/news_channel_headlines_model.dart";

String API_KEY = "568de588371843c09f4f66260cb4cab6";

class NewsRepository {
  Future<NewsChannelHeadlinesModel>fetchNewChannelHeadlinesApi(String channelName)async{
    String URL = "https://newsapi.org/v2/top-headlines?sources=$channelName&apiKey=$API_KEY";
    final response = await http.get(Uri.parse(URL));
    if(kDebugMode)
      {
        print(response.statusCode);
      }
    if(response.statusCode == 200)
      {
        final body = jsonDecode(response.body);
        return NewsChannelHeadlinesModel.fromJson(body);
      }
    else
      {
        throw Exception('Error');
      }
  }
  Future<CategoriesNewsModel>fetchCategoriesNewsApi(String categories)async{
    String URL = "https://newsapi.org/v2/everything?q=$categories&apiKey=$API_KEY";
    final response = await http.get(Uri.parse(URL));
    if(kDebugMode)
      {
        print(response.statusCode);
      }
    if(response.statusCode == 200)
      {
        final body = jsonDecode(response.body);
        return CategoriesNewsModel.fromJson(body);
      }
    else
      {
        throw Exception('Error');
      }
  }
}