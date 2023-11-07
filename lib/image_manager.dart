import 'package:flutter/material.dart';

class ImageManager {
  static String baseLocation = "images";
  // static getBasePath() async => baseLocation = "";

  static getImage(String subFolder, String imageName) {
    return Image.asset('$baseLocation/$subFolder/$imageName');
  }

  static String getImagePath(String subFolder, String imageName) {
    return '$baseLocation/$subFolder/$imageName';
  }
}

class ImageSubFolder {
  static String background = "background";
  static String balls = "balls";
  static String games = "games";
  static String icons = "icons";
  static String mons = "mons";
  static String types = "types";
}
