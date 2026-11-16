import 'package:flutter/material.dart';

const Color _customColor = Color.fromARGB(255, 151, 95, 240);

const List<Color> _colorThemes= [

  _customColor,
  Colors.blue,
  Colors.yellow,
  Colors.red,
  Colors.green,
  Colors.orange,
  Colors.pink
];

class AppTheme {

  final int selectedColor;

  AppTheme({this.selectedColor = 0})
  :assert(selectedColor >= 0 && selectedColor <= _colorThemes.length -1, 'El color debe estar entre 0 y ${_colorThemes.length}');

  ThemeData theme(){
    return ThemeData( 
      useMaterial3: true,
      colorSchemeSeed: _colorThemes[selectedColor]
    );
  }


}