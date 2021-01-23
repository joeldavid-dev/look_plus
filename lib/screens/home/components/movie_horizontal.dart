import 'package:flutter/material.dart';
import 'package:look_plus/models/pelicula_model.dart';

class MovieHorizontal extends StatelessWidget {
  final List<Pelicula> peliculas;
  final Function siguientePagina;

  MovieHorizontal({@required this.peliculas, @required this.siguientePagina});

  final _pageController = new PageController(
    initialPage: 1,
    viewportFraction: 0.3,
  );

  @override
  Widget build(BuildContext context) {
    _pageController.addListener(() {
      if (_pageController.position.pixels >=
          _pageController.position.maxScrollExtent - 200) {
        siguientePagina();
      }
    });
    return Container(
      height: 200,
      child: PageView.builder(
        pageSnapping: false, // Desactiva la sensacion de iman en el scroll
        controller: _pageController,
        itemCount: peliculas.length,
        itemBuilder: (context, i) => _targeta(context, peliculas[i]),
      ),
    );
  }

  Widget _targeta(BuildContext context, Pelicula pelicula) {
    final _tarjetaContainer = Container(
      margin: EdgeInsets.only(right: 15),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: FadeInImage(
              image: NetworkImage(pelicula.getPosterImg()),
              placeholder: AssetImage('assets/img/no-imagen.png'),
              fit: BoxFit.cover,
              height: 150,
            ),
          ),
          SizedBox(height: 5.0),
          Text(
            pelicula.title,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 12),
          ),
        ],
      ),
    );

    return GestureDetector(
      child: _tarjetaContainer,
      onTap: () {
        //Acciones cuando se da clic en una pelicula de Populares
        Navigator.pushNamed(context, 'detalle', arguments: pelicula);
      },
    );
  }
}
