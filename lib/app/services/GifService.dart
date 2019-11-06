import 'package:app_5_gifs/app/models/Gif.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'dart:async';

class GifService {

  static const String API_KEY = "8JKdl6cc6pA2cS4CV3C9gYAynZQsarVD";
  static const String SEARCH_URL = "https://api.giphy.com/v1/gifs/search?rating=G&lang=pt";
  static const String TRENDING_URL = "https://api.giphy.com/v1/gifs/trending?rating=G";

  Future<List<Gif>> getTrendingGifList({max = 20}) async{
    var url = "$TRENDING_URL&api_key=$API_KEY&limit=$max";
    return _getGifs(url);
  }

  Future<List<Gif>> getSearchGifList(query, {max = 19, offset = 0}) async{
    var url = "$SEARCH_URL&api_key=$API_KEY&limit=$max&offset=$offset&q=$query";
    return _getGifs(url);
  }

  Future<List<Gif>> _getGifs(url) async{
    var response = await http.get(url);
    var jsonGifs = convert.jsonDecode(response.body)["data"];

    List<Gif> gifs = [];
    jsonGifs.forEach((gif) {
      gifs.add(Gif(gif["id"], gif["title"],
          gif["images"]["fixed_height"]["url"]));
    });

    print(gifs);
    return gifs;

  }
}