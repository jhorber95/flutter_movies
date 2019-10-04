import 'package:flutter/material.dart';
import 'package:movies_app/src/models/pelicula_model.dart';

class MovieHorizontal extends StatelessWidget {

  List<Pelicula> peliculas;
  final Function siguientePagina;

  final _pageController = new PageController(
      initialPage: 1,
      viewportFraction: 0.3
  );

  MovieHorizontal({@required this.peliculas, @required this.siguientePagina});


  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery
        .of(context)
        .size;

    _pageController.addListener(() {
      /**
       * load next movies
       */
      if (_pageController.position.pixels >=
          _pageController.position.maxScrollExtent - 200) {
        siguientePagina();
      }
    });


    return Container(
      height: _screenSize.height * 0.3,
      /**
       * PageView.builder renderiza solo los items necesarios,
       */
      child: PageView.builder(
        pageSnapping: false,
        controller: _pageController,
        itemCount: peliculas.length,
        itemBuilder: (context, i) {
          return _tarjeta(context, peliculas[i]);
        },
//        children: _movieItems(context),
      ),
    );
  }

  Widget _tarjeta(BuildContext context, Pelicula pelicula) {
    final movieCard =  Container(
      margin: EdgeInsets.only(right: 15.0),
      child: Column(
        children: <Widget>[
          Hero(
            tag: pelicula.id,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: FadeInImage(
                image: NetworkImage(pelicula.getPosterImg()),
                placeholder: AssetImage('assets/jar-loading.gif'),
                fit: BoxFit.cover,
                height: 160.0,
              ),
            ),
          ),
          SizedBox(height: 5.0,),
          Text(pelicula.title, overflow: TextOverflow.ellipsis, style: Theme
              .of(context)
              .textTheme
              .caption,)
        ],
      ),
    );

    return GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, 'detalle', arguments: pelicula);
      },
      child: movieCard,
    );
  }


/*  List<Widget> _movieItems(BuildContext context) {
    return peliculas.map((pelicula) {
      return Container(
        margin: EdgeInsets.only(right: 15.0),
        child: Column(
          children: <Widget>[
            Hero(
              tag: pelicula.id ,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: FadeInImage(
                  image: NetworkImage(pelicula.getPosterImg()),
                  placeholder: AssetImage('assets/jar-loading.gif'),
                  fit: BoxFit.cover,
                  height: 160.0,
                ),
              ),
            ),
            SizedBox(height: 5.0,),
            Text(pelicula.title, overflow: TextOverflow.ellipsis, style: Theme
                .of(context)
                .textTheme
                .caption,)
          ],
        ),
      );
    }).toList();
  }*/
}
