import 'package:flutter/material.dart';

Color? colorFromName(String name) {
  switch (name.toLowerCase()) {
    case 'black':
      return Colors.black;
    case 'dark black':
      return Colors.black;
    case 'red':
      return Colors.red;
    case 'green':
      return Colors.green;
    case 'blue':
      return Colors.blue;
    case 'yellow':
      return Colors.yellow;
    case 'orange':
      return Colors.orange;
    case 'purple':
      return Colors.purple;
    case 'pink':
      return Colors.pink;
    case 'brown':
      return Colors.brown;
    case 'grey':
    case 'gray':
      return Colors.grey;
    case 'white':
      return Colors.white;
    case 'dark blue':
      return Colors.blue[900];
    case 'last':
      return Colors.transparent;
    default:
      return null;
  }
}
