import 'package:flutter/material.dart';
import 'package:look_plus/providers/peliculas_provider.dart';
import 'package:look_plus/screens/components/EstilosTexto.dart';
import 'package:look_plus/screens/components/barraTitulo.dart';

import 'components/cardSwiper.dart';
import 'components/movie_horizontal.dart';

class HomeScreen extends StatelessWidget {
  final peliculasProvider = new PeliculasProvider();

  @override
  Widget build(BuildContext context) {
    peliculasProvider.getProximos();
    peliculasProvider.getPopulares();
    peliculasProvider.getMejores();

    return Scaffold(
      body: Stack(
        children: [
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                    child: ListView(
                  cacheExtent: double.infinity,
                  /*Para mantener toda la pantalla en cache, de esta forma
                      se conserva todos los elementos intactos.
                      */
                  children: [
                    SizedBox(height: 90),
                    subtitulo('Peliculas en cines'),
                    SizedBox(height: 10),
                    _swiperTarjetas(),
                    SizedBox(height: 20),
                    subtitulo('Proximamente...'),
                    SizedBox(height: 10),
                    _footerProximos(context),
                    SizedBox(height: 20),
                    subtitulo('Populares'),
                    SizedBox(height: 10),
                    _footerPopulares(context),
                    SizedBox(height: 20),
                    subtitulo('Mejor calificadas'),
                    SizedBox(height: 10),
                    _footerMejores(context),
                    SizedBox(height: 20),
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

  Widget _footerProximos(BuildContext context) {
    return Container(
      child: StreamBuilder(
        //StreamBuilder construye el widget con datos obtenidos por Bloc
        stream: peliculasProvider
            .proximosStream, //Aqui se indica de donde se están escuchando los datos

        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          if (snapshot.hasData) {
            return MovieHorizontal(
              peliculas: snapshot.data,
              siguientePagina: peliculasProvider.getProximos,
              llave: 'Proximos',
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget _footerPopulares(BuildContext context) {
    return Container(
      child: StreamBuilder(
        //StreamBuilder construye el widget con datos obtenidos por Bloc
        stream: peliculasProvider
            .popularesStream, //Aqui se indica de donde se están escuchando los datos

        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          if (snapshot.hasData) {
            return MovieHorizontal(
              peliculas: snapshot.data,
              siguientePagina: peliculasProvider.getPopulares,
              llave: 'Populares',
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget _footerMejores(BuildContext context) {
    return Container(
      child: StreamBuilder(
        //StreamBuilder construye el widget con datos obtenidos por Bloc
        stream: peliculasProvider
            .mejoresStream, //Aqui se indica de donde se están escuchando los datos

        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          if (snapshot.hasData) {
            return MovieHorizontal(
              peliculas: snapshot.data,
              siguientePagina: peliculasProvider.getMejores,
              llave: 'Mejores',
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
