import 'package:flutter/material.dart';
import 'package:look_plus/constants.dart';
import 'package:look_plus/models/pelicula_model.dart';
import 'package:look_plus/providers/peliculas_provider.dart';

//En desuso

class DataSearch extends SearchDelegate {
  final peliculasProvider = new PeliculasProvider();

  @override
  List<Widget> buildActions(BuildContext context) {
    // Acciones de nuestro AppBar
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = '';
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Icono a la izquierda del AppBar
    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    // Crea los resultados que vamos a mostrar
    return Center(
      child: Container(),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Son las sugerencias que aparecen cuando el usuario escribe

    if (query.isEmpty) {
      return Container();
    }
    return FutureBuilder(
      future: peliculasProvider.buscarPelicula(query),
      builder: (BuildContext context, AsyncSnapshot<List<Pelicula>> snapshot) {
        if (snapshot.hasData) {
          final peliculas = snapshot.data;

          return ListView(
              children: peliculas.map((pelicula) {
            return ListTile(
              leading: FadeInImage(
                placeholder: AssetImage('assets/img/no-imagen.png'),
                image: NetworkImage(pelicula.getPosterImg()),
                width: 50,
                fit: BoxFit.contain,
              ),
              title: Text(pelicula.title),
              subtitle: Text(
                pelicula.originalTitle,
                style: TextStyle(color: colorLetras),
              ),
              onTap: () {
                close(context, null);
                pelicula.uniqueID = ''; //da error si es nulo
                Navigator.pushNamed(context, 'detalle', arguments: pelicula);
              },
            );
          }).toList());
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
