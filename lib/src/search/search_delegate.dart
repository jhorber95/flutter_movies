import 'package:flutter/material.dart';

class DataSearch  extends SearchDelegate{
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
      onPressed: (){
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
    return Container();
  }

}