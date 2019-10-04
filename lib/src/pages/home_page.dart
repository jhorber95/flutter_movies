import 'package:flutter/material.dart';
import 'package:movies_app/src/providers/pelicula_provider.dart';
import 'package:movies_app/src/search/search_delegate.dart';
import 'package:movies_app/src/widgets/card_swiper_widget.dart';
import 'package:movies_app/src/widgets/movie_horizontal.dart';

class HomePage extends StatelessWidget {
  final provider = new PeliculaProvider();

  @override
  Widget build(BuildContext context) {
    provider.getPopular();
    return Scaffold(
        appBar: AppBar(
          title: Text('Home Page'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(
                    context: context, delegate: DataSearch());
              },
            ),
          ],
        ),
        body: Container(
          child: Column(
//            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[_swiperTajetas(), _footer(context)],
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
              padding: const EdgeInsets.only(top: 20.0),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }

  Widget _footer(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 20.0, top: 20.0),
            child: Text(
              'Populares',
              style: Theme.of(context).textTheme.subhead,
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          StreamBuilder(
              stream: provider.popularsStream,
              builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
                if (snapshot.hasData) {
                  return MovieHorizontal(
                    peliculas: snapshot.data,
                    siguientePagina: provider.getPopular,
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
        ],
      ),
    );
  }
}
