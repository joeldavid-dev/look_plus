import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:look_plus/constants.dart';
import 'package:look_plus/screens/home/home.dart';
import 'package:look_plus/screens/movie_info/peliculaInfoScreen.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    systemNavigationBarColor: colorFondoApp,
  ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: tituloApp,
      theme: ThemeData(
        textTheme: Theme.of(context)
            .textTheme
            .apply(fontFamily: 'Varela', bodyColor: colorLetras),
        primarySwatch: Colors.blueGrey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: 'home',
      routes: {
        'home': (BuildContext context) => HomeScreen(),
        'detalle': (BuildContext context) => PeliculaInfoScreen(),
      },
    );
  }
}
