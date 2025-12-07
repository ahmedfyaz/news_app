import 'package:http/http.dart'as http;
import 'package:news_app/models/news_channel_headlines_model.dart';
import 'package:news_app/repository/news_repository.dart';

class NewsViewModel {
  final _rep = NewsRepository();
  Future<NewsChannelHeadlinesModel> fetchNewChannelHeadlinesApi()async{
    final response = await _rep.fetchNewChannelHeadlinesApi();
    return response;
  }
}