import 'package:flutter/material.dart';
import 'package:movies_app/src/pages/home_page.dart';
import 'package:movies_app/src/routes/routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Peliculas',
      initialRoute: '/',
      routes: getApplicationRoutes(),
      onGenerateRoute: (RouteSettings settings) {
        print('Route error: ${settings.name}');
        return MaterialPageRoute(
            builder: (BuildContext context) => HomePage());
      },
    );
  }
}
