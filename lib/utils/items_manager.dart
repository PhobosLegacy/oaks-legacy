import 'dart:convert';
import 'package:collection/collection.dart';
import 'package:proto_dex/file_manager.dart';
import '../models/game.dart';
import '../models/group.dart';
import '../models/item.dart';

retrieveItems(String key) {
  String content = FileManager.get(key);
  if (content.isEmpty) return List<Item>.empty(growable: true);
  return List<Item>.from(
      (jsonDecode(content)).map((model) => Item.fromJson(model)));
}

saveItems(String key, List<Item> collection) =>
    FileManager.save(key, jsonEncode(collection));

addItems(String key, List<Item> items) {
  List<Item> collection = retrieveItems(key);
  List<Item> toAddToCollection = [];
  for (var item in items) {
    if (item.forms.isEmpty) {
      toAddToCollection.add(item);
    } else {
      item.forms.removeWhere((element) => element.captured == false);
      toAddToCollection.addAll(item.forms);
    }
  }

  for (var pokemon in toAddToCollection) {
    collection.removeWhere((element) =>
        element.ref == pokemon.ref && element.origin == pokemon.origin);
    collection.add(pokemon);
  }
  // collection.sort((a, b) => int.parse(a.number).compareTo(int.parse(b.number)));
  saveItems(key, collection);
}

groupByPokemon(List<Item> collection) {
  List<Group> groups = [];
  var newMap = groupBy(collection, (Item obj) => obj.name);
  for (var map in newMap.entries) {
    Group group = Group(
        name: map.value.first.name,
        items: map.value,
        image: 'mons/${map.value.first.image.first}');
    group.items.sortBy((element) => element.natDexNumber);
    groups.add(group);
  }
  groups.sortBy((element) => element.items.first.ref);
  return groups;
}

groupByCurrentGame(List<Item> collection) {
  List<Group> groups = [];
  var newMap = groupBy(collection, (Item obj) => obj.currentLocation);
  for (var map in newMap.entries) {
    Group group =
        Group(name: map.key, items: map.value, image: Game.gameIcon(map.key));
    group.items.sortBy((element) => element.number);
    group.color = Game.gameColor(group.name);
    groups.add(group);
  }
  return groups;
}

groupByOriginGame(List<Item> collection) {
  List<Group> groups = [];
  var newMap = groupBy(collection, (Item obj) => obj.originalLocation);
  for (var map in newMap.entries) {
    Group group =
        Group(name: map.key, items: map.value, image: Game.gameIcon(map.key));
    group.items.sortBy((element) => element.number);
    group.color = Game.gameColor(group.name);
    groups.add(group);
  }
  return groups;
}
