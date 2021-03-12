import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:look_plus/constants.dart';
import 'package:look_plus/screens/home.dart';
import 'package:look_plus/screens/peliculaInfoScreen.dart';
import 'package:look_plus/screens/search_screen.dart';

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
        //El brillo del tema en general es oscuro. Ayuda a que el status bar no se oscurezca.
        brightness: Brightness.dark,
        appBarTheme: AppBarTheme(color: colorAcento),
        scaffoldBackgroundColor: colorFondoApp,
        textTheme: Theme.of(context)
            .textTheme
            .apply(fontFamily: 'Varela', bodyColor: colorLetras),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        accentColor: colorAcento,
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
