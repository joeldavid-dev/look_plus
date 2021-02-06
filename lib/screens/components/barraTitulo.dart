import 'package:flutter/material.dart';
import 'package:look_plus/search/search_delegate.dart';

import '../../constants.dart';

class BarraTitulo extends StatefulWidget {
  BarraTitulo({Key key}) : super(key: key);

  @override
  _BarraTituloState createState() => _BarraTituloState();
}

class _BarraTituloState extends State<BarraTitulo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
          left: margenApp, right: margenApp, top: 15, bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Center(
            child: Text(tituloApp,
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          ),
          IconButton(
              icon: Icon(
                Icons.search,
                color: colorAcento,
              ),
              onPressed: () {
                showSearch(context: context, delegate: DataSearch(), query: '');
              })
        ],
      ),
    );
  }
}
