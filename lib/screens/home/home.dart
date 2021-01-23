import 'package:flutter/material.dart';
import 'package:look_plus/constants.dart';
import 'package:look_plus/providers/peliculas_provider.dart';

import 'components/cardSwiper.dart';
import 'components/movie_horizontal.dart';

class HomeScreen extends StatelessWidget {
  final peliculasProvider = new PeliculasProvider();

  @override
  Widget build(BuildContext context) {
    peliculasProvider.getPopulares();

    return Scaffold(
      appBar: _buildAppBar(),
      backgroundColor: colorFondoApp,
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: margenApp),
                child: _titulo(tituloApp)),
            SizedBox(height: 10),
            Expanded(
                child: ListView(
              children: [
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: margenApp),
                    child: _subtitulo('Peliculas en cines')),
                SizedBox(height: 10),
                _swiperTarjetas(),
                SizedBox(height: 20),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: margenApp),
                    child: _subtitulo('Populares')),
                SizedBox(height: 10),
                _footer(context),
              ],
            ))
          ]),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
        backgroundColor: colorFondoApp,
        elevation: 0,
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.search,
                color: colorAcento,
              ),
              onPressed: null)
        ]);
  }

  Text _titulo(String texto) {
    return Text(texto,
        style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold));
  }

  Text _subtitulo(String texto) {
    return Text(texto, style: TextStyle(fontSize: 18));
  }

  Widget _swiperTarjetas() {
    return FutureBuilder(
      future: peliculasProvider.getEnCines(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          return CardSwiper(peliculas: snapshot.data);
        } else {
          return Container(
            height: 400,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }

  Widget _footer(BuildContext context) {
    return Container(
      width: double.infinity,
      child: StreamBuilder(
        //StreamBuilder construye el widget con datos obtenidos por Bloc
        stream: peliculasProvider
            .popularesStream, //Aqui se indica de donde se están escuchando los datos

        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          if (snapshot.hasData) {
            return MovieHorizontal(
              peliculas: snapshot.data,
              siguientePagina: peliculasProvider.getPopulares,
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
