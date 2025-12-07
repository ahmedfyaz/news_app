import 'package:http/http.dart'as http;
import 'package:news_app/models/categories_news_model.dart';
import 'package:news_app/models/news_channel_headlines_model.dart';
import 'package:news_app/repository/news_repository.dart';

class NewsViewModel {
  final _rep = NewsRepository();
  Future<NewsChannelHeadlinesModel> fetchNewChannelHeadlinesApi(String channelName)async{
    final response = await _rep.fetchNewChannelHeadlinesApi(channelName);
    return response;
  }
  Future<CategoriesNewsModel> fetchCategoriesNewsApi(String channelName)async{
    final response = await _rep.fetchCategoriesNewsApi(channelName);
    return response;
  }
}