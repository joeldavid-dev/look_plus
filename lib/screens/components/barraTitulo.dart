import 'dart:ui';

import 'package:flutter/material.dart';

import '../../constants.dart';

class BarraTitulo extends StatefulWidget {
  BarraTitulo({Key key}) : super(key: key);

  @override
  _BarraTituloState createState() => _BarraTituloState();
}

class _BarraTituloState extends State<BarraTitulo> {
  @override
  Widget build(BuildContext context) {
    final double anchoPantalla = MediaQuery.of(context).size.width;

    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          width: anchoPantalla,
          decoration: BoxDecoration(color: colorFondoTranslucido),
          padding: const EdgeInsets.only(
              left: margenApp, right: margenApp, top: 10, bottom: 5),
          child: SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Center(
                  child: Text(tituloApp,
                      style:
                          TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                ),
                IconButton(
                    icon: Icon(
                      Icons.search,
                      color: colorAcento,
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, 'busqueda');
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
