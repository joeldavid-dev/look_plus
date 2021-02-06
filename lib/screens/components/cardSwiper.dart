import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:look_plus/models/pelicula_model.dart';

class CardSwiper extends StatelessWidget {
  final List<Pelicula> peliculas;

  CardSwiper({@required this.peliculas});

  @override
  Widget build(BuildContext context) {
    return Container(
      //padding: EdgeInsets.only(top: 5),
      child: Swiper(
        layout: SwiperLayout.STACK,
        itemWidth: 266,
        itemHeight: 400,
        itemBuilder: (BuildContext context, int index) {
          peliculas[index].uniqueID = '${peliculas[index].id}-enCines';

          return Hero(
            tag: peliculas[index].uniqueID,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: GestureDetector(
                child: FadeInImage(
                  placeholder: AssetImage('assets/img/no-imagen.png'),
                  image: NetworkImage(peliculas[index].getPosterImg()),
                  fit: BoxFit.cover,
                ),
                onTap: () {
                  //Acciones cuando se da clic en una pelicula de Populares
                  Navigator.pushNamed(context, 'detalle',
                      arguments: peliculas[index]);
                },
              ),
            ),
          );
        },
        itemCount: peliculas.length,
        //pagination: SwiperPagination(),
        //control: SwiperControl(),
      ),
    );
  }
}
