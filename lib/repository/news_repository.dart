import "dart:convert";

import "package:http/http.dart" as http;
import "package:news_app/models/news_channel_headlines_model.dart";

String API_KEY = "568de588371843c09f4f66260cb4cab6";

class NewsRepository {
  Future<NewsChannelHeadlinesModel>fetchNewChannelHeadlinesApi()async{
    String URL = "https://newsapi.org/v2/top-headlines?sources=bbc-news&apiKey=$API_KEY";
    final response = await http.get(Uri.parse(URL));
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
}