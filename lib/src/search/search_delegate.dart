import 'package:flutter/material.dart';
import 'package:movies_app/src/models/pelicula_model.dart';
import 'package:movies_app/src/providers/pelicula_provider.dart';

class DataSearch extends SearchDelegate {
  final _movieProvider = new PeliculaProvider();

  @override
  List<Widget> buildActions(BuildContext context) {
    // acciones del navbar: limpiar, cancelar, etc
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // icono a la izquierda del buscador
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // crea los resultado a mostrar
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // mostrar sugerencias de busqueda
    if (query.isEmpty) return Container();

    return FutureBuilder(
        future: _movieProvider.searchMovies(query),
        builder: (BuildContext context, AsyncSnapshot<List<Pelicula>> snapshot) {
          if (snapshot.hasData) {
            final movies = snapshot.data;
            return ListView(
              children: _createListSuggestions(context, movies)
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        }
        );
  }
  
  List<Widget> _createListSuggestions(BuildContext context, List<Pelicula> movies) {
    print(movies.length);
    return movies.map((movie) {
      return ListTile(
        leading: FadeInImage(
          image: NetworkImage(movie.getPosterImg()),
          placeholder: AssetImage('assets/jar-loaging.gif'),
          width: 50,
          fit: BoxFit.contain,
        ),
        title: Text(movie.title),
        subtitle: Text(movie.originalTitle),
        onTap: (){
          close(context, null);
          movie.uniqueId = '';
          Navigator.pushNamed(context, 'detalle', arguments: movie);
        },
      );
    }).toList();
  }
}
