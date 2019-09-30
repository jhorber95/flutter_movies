import 'package:flutter/material.dart';
import 'package:movies_app/src/providers/pelicula_provider.dart';
import 'package:movies_app/src/widgets/card_swiper_widget.dart';

class HomePage extends StatelessWidget {
  final provider = new PeliculaProvider();

  List<dynamic> movies = [1, 2, 3, 4, 5];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Home Page'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {},
            ),
          ],
        ),
        body: Container(
          child: Column(
            children: <Widget>[_swiperTajetas()],
          ),
        ));
  }

  Widget _swiperTajetas() {
    return FutureBuilder(
        future: provider.getEnCines(),
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          if (snapshot.hasData) {
            return CardSwiper(
              peliculas: snapshot.data,
            );
          } else {
            return Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }
}
