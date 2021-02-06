import 'package:flutter/material.dart';
import 'package:look_plus/models/pelicula_model.dart';
import 'package:look_plus/models/actores_model.dart';
import 'package:look_plus/providers/peliculas_provider.dart';

class CastingHorizontal extends StatelessWidget {
  final Pelicula pelicula;

  CastingHorizontal({@required this.pelicula});

  @override
  Widget build(BuildContext context) {
    final peliProvider = new PeliculasProvider();

    return FutureBuilder(
        future: peliProvider.getCast(pelicula.id.toString()),
        builder: (context, AsyncSnapshot<List> snapshot) {
          if (snapshot.hasData) {
            return _crearActoresPageView(snapshot.data);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }

  Widget _crearActoresPageView(List<Actor> actores) {
    return SizedBox(
      height: 130,
      child: PageView.builder(
        pageSnapping: false,
        controller: PageController(viewportFraction: 0.3, initialPage: 1),
        itemCount: actores.length,
        itemBuilder: (context, i) => _actorTarjeta(actores[i]),
      ),
    );
  }

  Widget _actorTarjeta(Actor actor) {
    return Container(
      child: Column(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(actor.getFoto()),
            radius: 40,
          ),
          Text(actor.name,
              overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}
