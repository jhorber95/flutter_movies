import 'dart:convert';

import 'package:movies_app/src/models/pelicula_model.dart';
import 'package:http/http.dart' as http;

class PeliculaProvider {
  String _apiKey = '488ebb6f3e8eb678e2a63e8cc26424f9';
  String _url = 'api.themoviedb.org';
  String _lang = 'en-US';

  Future<List<Pelicula>> _makeResponse(Uri url) async {
    final response = await http.get(url);
    final decodedData = json.decode(response.body);

    final peliculas = new Peliculas.fromJsonList(decodedData['results']);

    return peliculas.items;
  }

  Future<List<Pelicula>> getEnCines() async {
    final url = Uri.https(
        _url, '3/movie/now_playing', {'api_key': _apiKey, 'language': _lang});

    return _makeResponse(url);
  }

  Future<List<Pelicula>> getPopular() async {
    final url = Uri.https(
        _url, '3/movie/popular', {'api_key': _apiKey, 'language': _lang});
    return _makeResponse(url);
  }
}
