

import 'package:flutter/material.dart';
import 'package:movies_app/src/pages/home_page.dart';
import 'package:movies_app/src/pages/movie_detail_page.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    '/': (BuildContext context) => HomePage(),
    'detalle': (BuildContext context) => MovieDetailPage(),
  };
}

