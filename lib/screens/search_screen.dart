import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:look_plus/constants.dart';
import 'package:look_plus/models/pelicula_model.dart';
import 'package:look_plus/providers/peliculas_provider.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final peliculasProvider = new PeliculasProvider();
    return Scaffold(
      body: SafeArea(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: margenApp),
              child: SearchBar(
                textStyle:
                    TextStyle(color: colorLetras, fontWeight: FontWeight.bold),
                minimumChars: 2,
                loader: Center(
                  child: CircularProgressIndicator(),
                ),
                //cancellationWidget: Text('Cancelar'),
                crossAxisCount: 3,
                hintText: "Buscar",
                hintStyle:
                    TextStyle(color: colorLetras, fontWeight: FontWeight.bold),
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,

                onSearch: peliculasProvider.buscarPelicula,
                onItemFound: (Pelicula pelicula, int index) {
                  return _tarjetaResultado(context, pelicula);
                },
              ))),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  Widget _tarjetaResultado(BuildContext context, Pelicula pelicula) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: GestureDetector(
        child: FadeInImage(
          placeholder: AssetImage('assets/img/no-imagen.png'),
          image: NetworkImage(pelicula.getPosterImg()),
          fit: BoxFit.cover,
        ),
        onTap: () {
          //Acciones cuando se da clic en una pelicula
          pelicula.uniqueID = ''; //da error si es nulo
          Navigator.pushNamed(context, 'detalle', arguments: pelicula);
        },
      ),
    );
  }
}
