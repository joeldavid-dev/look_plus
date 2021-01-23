import 'package:flutter/material.dart';
import 'package:look_plus/constants.dart';
import 'package:look_plus/models/pelicula_model.dart';

class PeliculaInfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Pelicula pelicula = ModalRoute.of(context).settings.arguments;
    final _screenSize = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: colorFondoApp,
        body: CustomScrollView(
          slivers: <Widget>[
            _crearAppbar(pelicula, _screenSize.height),
            SliverList(
              delegate: SliverChildListDelegate([
                SizedBox(height: 10),
                _posterTitulo(context, pelicula),
                _descripcion(pelicula),
                _descripcion(pelicula),
                _descripcion(pelicula),
                _descripcion(pelicula),
                _descripcion(pelicula),
              ]),
            )
          ],
        ));
  }

  Widget _crearAppbar(Pelicula pelicula, double heightPantalla) {
    return SliverAppBar(
      elevation: 0,
      backgroundColor: colorAcento,
      expandedHeight: heightPantalla * 0.6,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          pelicula.title,
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontFamily: 'Varela'),
          textAlign: TextAlign.center,
        ),
        background: FadeInImage(
          placeholder: AssetImage('assets/img/loading.gif'),
          image: NetworkImage(pelicula.getBackgroundImg()),
          //Me da error fadeInDuration: Duration(microseconds: 150),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _posterTitulo(BuildContext context, Pelicula pelicula) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: margenApp),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image(
              image: NetworkImage(pelicula.getPosterImg()),
              height: 150,
            ),
          ),
          SizedBox(width: 20),
          Flexible(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                pelicula.originalTitle,
                style: Theme.of(context).textTheme.subtitle1,
                overflow: TextOverflow.ellipsis,
              ),
              Row(
                children: [
                  Icon(Icons.star_border, color: colorAcento),
                  Text(pelicula.voteAverage.toString())
                ],
              )
            ],
          ))
        ],
      ),
    );
  }

  Widget _descripcion(Pelicula pelicula) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: margenApp, vertical: 30),
      child: Text(pelicula.overview),
    );
  }
}
