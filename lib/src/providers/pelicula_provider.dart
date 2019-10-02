import 'dart:async';
import 'dart:convert';

import 'package:movies_app/src/models/actor_model.dart';
import 'package:movies_app/src/models/pelicula_model.dart';
import 'package:http/http.dart' as http;

class PeliculaProvider {
  String _apiKey = '488ebb6f3e8eb678e2a63e8cc26424f9';
  String _url = 'api.themoviedb.org';
  String _lang = 'en-US';

  int _pagePopular = 0;
  bool _loading = false;

  List<Pelicula> _populars = new List();

  final _popularStreamController  = StreamController<List<Pelicula>>.broadcast();

  Function(List<Pelicula>) get popularsSink => _popularStreamController.sink.add;

  Stream<List<Pelicula>> get popularsStream => _popularStreamController.stream;


  void dispose() {
    _popularStreamController?.close();
  }

  Future<List<Pelicula>> _makeMoviesResponse(Uri url) async {
    final response = await http.get(url);
    final decodedData = json.decode(response.body);

    final peliculas = new Peliculas.fromJsonList(decodedData['results']);

    return peliculas.items;
  }

  Future<List<Pelicula>> getEnCines() async {
    final url = Uri.https(
        _url, '3/movie/now_playing', {'api_key': _apiKey, 'language': _lang});

    return await _makeMoviesResponse(url);
  }

  Future<List<Pelicula>> getPopular() async {
    if(_loading) return [];

    _loading  = true;
    _pagePopular++;

    final url = Uri.https(_url, '3/movie/popular', {
      'api_key': _apiKey,
      'language': _lang,
      'page': _pagePopular.toString()
    });

    final response = await _makeMoviesResponse(url);
    _populars.addAll(response);
    popularsSink(_populars);

    _loading = false;
    return response;
  }

  Future<List<Actor>> getCast(int movieId) async {
    final url = Uri.https(_url, '3/movie/$movieId/credits',{
      'api_key': _apiKey,
      'language': _lang,
    });

    final response = await http.get(url);
    final decodedData = json.decode(response.body);

    final cast = new Cast.fromJsonList(decodedData['cast']);
    return cast.actorList;
  }
}
