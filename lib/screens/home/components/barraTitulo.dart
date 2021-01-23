import 'package:flutter/material.dart';

import '../../../constants.dart';

class BarraTitulo extends StatefulWidget {
  BarraTitulo({Key key}) : super(key: key);

  @override
  _BarraTituloState createState() => _BarraTituloState();
}

class _BarraTituloState extends State<BarraTitulo> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: margenApp, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(tituloApp,
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
          IconButton(
              icon: Icon(
                Icons.search,
                color: colorAcento,
              ),
              onPressed: null)
        ],
      ),
    );
  }
}
