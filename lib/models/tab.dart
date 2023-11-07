import 'package:flutter/material.dart';

class PokeTab {
  PokeTab(
      {required this.tabName, required this.leftCard, required this.rightCard});
  String tabName;
  Widget leftCard;
  Widget rightCard;

  head() {
    return Tab(text: tabName);
  }

  cards() {
    return Row(
      children: [leftCard, rightCard],
    );
  }
}
