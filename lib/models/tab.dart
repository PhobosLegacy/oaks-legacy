import 'package:flutter/material.dart';

class PokeTab {
  PokeTab({required this.tabName, required this.tabContent});
  String tabName;
  Widget tabContent;

  head() {
    return Tab(text: tabName);
  }

  cards() {
    return tabContent;
  }
}
