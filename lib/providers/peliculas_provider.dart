import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:look_plus/models/actores_model.dart';
import 'package:look_plus/models/pelicula_model.dart';

/*
Proveedor de la aplicación, se encarga de conectarse a la API de
the movie database y de dar tratamiento a los datos obtenidos.
*/
class PeliculasProvider {
  String _apikey = '1865f43a0549ca50d341dd9ab8b29f49';
  String _url = 'api.themoviedb.org';
  String _language = 'es-MX';

  int _popularesPage = 0;
  bool _cargando = false;

  List<Pelicula> _populares = new List();

  //Inicia bloc
  final _popularesStreamController =
      StreamController<List<Pelicula>>.broadcast();

  Function(List<Pelicula>) get popularesSink =>
      _popularesStreamController.sink.add; //introducir peliculas

  Stream<List<Pelicula>> get popularesStream =>
      _popularesStreamController.stream; //escuchar las peliculas

  void disposeStreams() {
    _popularesStreamController.close();
  }
  //termina bloc

  Future<List<Pelicula>> _procesarRespuesta(Uri url) async {
    final resp = await http.get(url);

    final decodedData = json.decode(resp.body);

    final peliculas = new Peliculas.fromJsonList(decodedData['results']);

    return peliculas.items;
  }

  Future<List<Pelicula>> getEnCines() async {
    final url = Uri.https(_url, '3/movie/now_playing', {
      'api_key': _apikey,
      'language': _language,
    });
    return await _procesarRespuesta(url);
  }

  Future<List<Pelicula>> getPopulares() async {
    if (_cargando) return [];
    /*_cargando es un booleano que se cierra cuando ya hay un Future ejecutandose,
    de esta forma se evita que se hagan muchas solicitudes a la api y que descarge 
    la misma información inesesariamente. Parecido a un cerrojo en hilos de
    Java*/
    _cargando = true;

    _popularesPage++;

    final url = Uri.https(_url, '3/movie/popular', {
      'api_key': _apikey,
      'language': _language,
      'page': _popularesPage.toString(),
    });

    final resp = await _procesarRespuesta(url);
    _populares.addAll(resp);
    popularesSink(_populares);
    _cargando = false;
    return resp;
  }

  Future<List<Actor>> getCast(String peliId) async {
    final url = Uri.https(_url, '3/movie/$peliId/credits', {
      'api_key': _apikey,
      'language': _language,
    });

    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);

    final cast = new Cast.fromJsonList(decodedData['cast']);

    return cast.actores;
  }

  Future<List<Pelicula>> buscarPelicula(String query) async {
    final url = Uri.https(_url, '3/search/movie', {
      'api_key': _apikey,
      'language': _language,
      'query': query,
    });
    return await _procesarRespuesta(url);
  }
}
