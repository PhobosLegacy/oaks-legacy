import 'dart:ui';

import 'item.dart';

class Group {
  Group({required this.name, required this.items, required this.image});

  final String name;
  final List<Item> items;
  final String image;
  Color? color;
}
