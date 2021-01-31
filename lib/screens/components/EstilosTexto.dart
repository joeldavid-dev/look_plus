import 'package:flutter/material.dart';
import 'package:look_plus/constants.dart';

Padding subtitulo(String texto) {
  return Padding(
      padding: const EdgeInsets.symmetric(horizontal: margenApp),
      child: Text(texto,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)));
}
