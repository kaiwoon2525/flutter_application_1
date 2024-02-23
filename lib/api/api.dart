import 'package:flutter_application_1/constants.dart';
import 'package:flutter_application_1/models/movie.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Api {
  static const trendingURL =
      'https://api.themoviedb.org/3/trending/movie/day?api_key=${Constants.apiKey}';

  static const toprategURL =
      'https://api.themoviedb.org/3/movie/top_rated?api_key=${Constants.apiKey}';

  static const upcomingURL =
      'https://api.themoviedb.org/3/movie/upcoming?api_key=${Constants.apiKey}';

  Future<List<Movie>> getTrendingMovies() async {
    final resopnes = await http.get(Uri.parse(trendingURL));
    if (resopnes.statusCode == 200) {
      final decodedData = json.decode(resopnes.body)['results'] as List;
      //print(decodedData);
      return decodedData.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception('error');
    }
  }

  Future<List<Movie>> getToprateMovies() async {
    final resopnes = await http.get(Uri.parse(toprategURL));
    if (resopnes.statusCode == 200) {
      final decodedData = json.decode(resopnes.body)['results'] as List;
      //print(decodedData);
      return decodedData.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception('error');
    }
  }

  Future<List<Movie>> getupcomingMovies() async {
    final resopnes = await http.get(Uri.parse(upcomingURL));
    if (resopnes.statusCode == 200) {
      final decodedData = json.decode(resopnes.body)['results'] as List;
      //print(decodedData);
      return decodedData.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception('error');
    }
  }
}
