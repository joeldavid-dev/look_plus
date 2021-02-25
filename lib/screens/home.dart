import 'package:flutter/material.dart';
import 'package:look_plus/constants.dart';
import 'package:look_plus/providers/peliculas_provider.dart';
import 'package:look_plus/screens/components/EstilosTexto.dart';
import 'package:look_plus/screens/components/barraTitulo.dart';

import 'components/cardSwiper.dart';
import 'components/movie_horizontal.dart';

class HomeScreen extends StatelessWidget {
  final peliculasProvider = new PeliculasProvider();

  @override
  Widget build(BuildContext context) {
    peliculasProvider.getPopulares();

    return Scaffold(
      body: Stack(
        children: [
          _fondoGradiente(),
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                    child: ListView(
                  children: [
                    SizedBox(height: 80),
                    subtitulo('Peliculas en cines'),
                    SizedBox(height: 10),
                    _swiperTarjetas(),
                    SizedBox(height: 20),
                    subtitulo('Populares'),
                    SizedBox(height: 10),
                    _footer(context),
                  ],
                ))
              ]),
          Positioned(top: 0, child: BarraTitulo()),
        ],
      ),
    );
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

  Widget _fondoGradiente() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: FractionalOffset(0.0, 0.6),
          end: FractionalOffset(0.0, 1.0),
          colors: [
            colorFondoApp,
            Colors.black,
          ],
        ),
      ),
    );
  }
}
