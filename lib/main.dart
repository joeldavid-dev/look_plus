import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:look_plus/constants.dart';
import 'package:look_plus/screens/home.dart';
import 'package:look_plus/screens/peliculaInfoScreen.dart';
import 'package:look_plus/screens/search_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: colorFondoApp,
    ));

    return MaterialApp(
      title: tituloApp,
      theme: ThemeData(
        floatingActionButtonTheme:
            FloatingActionButtonThemeData(backgroundColor: colorAcento),
        appBarTheme: AppBarTheme(color: colorAcento),
        scaffoldBackgroundColor: colorFondoApp,
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
        'busqueda': (BuildContext context) => SearchScreen(),
      },
    );
  }
}
