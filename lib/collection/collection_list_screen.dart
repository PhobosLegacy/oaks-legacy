import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:proto_dex/components/base_background.dart';
import 'package:proto_dex/components/button_filters.dart';
import 'package:proto_dex/components/button_screenshot.dart';
import 'package:proto_dex/components/button_search.dart';
import 'package:proto_dex/constants.dart';
import 'package:proto_dex/models/game.dart';
import 'package:screenshot/screenshot.dart';
import '../components/app_bar.dart';
import '../components/filters_side_screen.dart';
import '../components/group_list_by.dart';
import '../components/search_bar.dart';
import '../models/enums.dart';
import '../models/group.dart';
import '../models/item.dart';
import '../models/pokemon.dart';
import '../utils/items_manager.dart';
import 'collection_cards.dart';
import 'collection_details_screen.dart';
import 'collection_tile.dart';
import '../pokedex/pokedex_cards.dart' as dex_card;

class CollectionScreen extends StatefulWidget {
  const CollectionScreen({
    super.key,
  });

  @override
  State<CollectionScreen> createState() => _CollectionScreenState();
}

class _CollectionScreenState extends State<CollectionScreen> {
  final controller = ScreenshotController();
  String _query = "";
  int _selectedTab = 0;
  bool _isSearchOpened = false;
  CollectionDisplayType displayType = CollectionDisplayType.flatList;
  List<Item> collection = List<Item>.empty(growable: true);
  List<Pokemon> originalPokedex = [];
  List<FilterType> filters = [];
  TextEditingController editingController = TextEditingController();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    originalPokedex.addAll(kPokedex);
    collection = retrieveItems(kCollectionKey);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: scaffoldKey,
      appBar: AppBarBase(
        title: Column(
          children: [
            const Text("My Collection"),
            if (displayType != CollectionDisplayType.flatList)
              Text(
                getSubTitle(displayType),
                style: const TextStyle(
                  fontSize: 10,
                  fontStyle: FontStyle.italic,
                ),
              ),
          ],
        ),
        actions: appBarActions(),
        color: Colors.blueGrey[800],
      ),
      endDrawer: FiltersSideScreen(
        filters: trackerFilters(),
        onClose: () {
          setState(() => scaffoldKey.currentState!.closeEndDrawer());
        },
      ),
      body: Stack(
        children: <Widget>[
          const BaseBackground(),
          SafeArea(
            child: Column(
              children: [
                Search(
                  isSearchOpened: _isSearchOpened,
                  editingController: editingController,
                  onCloseTap: () => {
                    setState(
                      () {
                        (editingController.text == "")
                            ? _isSearchOpened = false
                            : editingController.clear();
                        _query = "";
                        applyFilters();
                      },
                    )
                  },
                  onValueChange: (value) {
                    _query = value;
                    applyFilters();
                  },
                ),
                if (_selectedTab == 0 && collection.isEmpty)
                  const Expanded(
                    child: Center(
                      child: Text(
                        "You have no mons in your collection",
                        style: TextStyle(color: Colors.yellow, fontSize: 15),
                      ),
                    ),
                  ),
                if (_selectedTab == 0 && collection.isNotEmpty)
                  collectionList(),
                if (_selectedTab == 1) pokedex()
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.check_circle_outline_outlined),
            label: "Collection",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle),
            label: "Add",
          ),
        ],
        currentIndex: _selectedTab,
        backgroundColor: Colors.blueGrey[800],
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.black,
        onTap: (int index) {
          setState(
            () {
              _selectedTab = index;
            },
          );
        },
      ),
    );
  }

  collectionList() {
    List<Group> groups;
    switch (displayType) {
      case CollectionDisplayType.groupByCurrentGame:
        groups = groupByCurrentGame(collection);
        break;
      case CollectionDisplayType.groupByOriginalGame:
        groups = groupByOriginGame(collection);
        break;
      case CollectionDisplayType.groupByPokemon:
      default:
        groups = groupByPokemon(collection);
        break;
    }

    return Expanded(
      child: SingleChildScrollView(
        child: Screenshot(
          controller: controller,
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: (CollectionDisplayType.flatList == displayType)
                ? collection.length
                : groups.length,
            itemBuilder: ((context, index) {
              return (displayType == CollectionDisplayType.flatList)
                  ? CollectionTile(
                      pokemons: collection,
                      indexes: [index],
                      onStateChange: (item) {
                        setState(() {
                          saveToCollection(item);
                        });
                      },
                      onDelete: (item) {
                        setState(() {
                          removeFromColletion(item);
                        });
                      },
                    )
                  : createCards(
                      groups[index],
                      onStateChange: (item) {
                        setState(() {
                          saveToCollection(item);
                        });
                      },
                      onDelete: (item) {
                        setState(() {
                          removeFromColletion(item);
                        });
                      },
                    );
            }),
          ),
        ),
      ),
    );
  }

  void removeFromColletion(Item item) {
    collection = retrieveItems(kCollectionKey);
    collection.removeWhere((element) => element.ref == item.ref);
    saveItems(kCollectionKey, collection);
    collection = collection.applyAllFilters(filters, _query);
  }

  void saveToCollection(Item item) {
    collection = retrieveItems(kCollectionKey);
    final index = collection.indexWhere((element) => element.ref == item.ref);
    if (index == -1) {
      collection.add(item);
    } else {
      collection[index] = item;
    }
    saveItems(kCollectionKey, collection);
    collection = collection.applyAllFilters(filters, _query);
  }

  void applyFilters() {
    setState(() {
      (_query == "")
          ? removeFilters([FilterType.byValue])
          : addFilter(FilterType.byValue);

      collection = retrieveItems(kCollectionKey);
      collection = collection.applyAllFilters(filters, _query);

      originalPokedex = originalPokedex.applyAllFilters(filters, _query, null);
    });
  }

  void addFilter(FilterType filter) {
    if (!filters.contains(filter)) filters.add(filter);
  }

  void removeFilters(List<FilterType> filtersToRemove) {
    for (var element in filtersToRemove) {
      filters.remove(element);
    }
  }

  List<Widget> appBarActions() {
    return [
      SearchButton(
        onPressed: () {
          setState(() {
            _isSearchOpened = !_isSearchOpened;
          });
        },
      ),
      if (_selectedTab == 0) ScreenShotButton(screenshotController: controller),
      if (_selectedTab == 0) FiltersButton(scaffoldKey: scaffoldKey),
    ];
  }

  List<Widget> trackerFilters() {
    return [
      const Divider(thickness: 2),
      GroupListBy(
        currentDisplay: displayType,
        onDisplaySelected: (newDisplay) {
          setState(() {
            displayType = newDisplay;
            applyFilters();
          });
        },
      ),
    ];
  }

//This is the Second Tab Bits
  Expanded pokedex() {
    return Expanded(
      child: ListView.builder(
        itemBuilder: ((context, index) {
          return dex_card.createCards(
            originalPokedex,
            [index],
            onStateChange: (indexes) {
              List<Item> items = [createItem(originalPokedex, indexes)];
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return CollectionDetailsPage(
                      pokemons: items,
                      indexes: const [0],
                      onStateChange: (item) {
                        saveToCollection(item);
                      },
                    );
                  },
                ),
              );
              setState(() {
                () => {};
              });
            },
          );
        }),
        itemCount: originalPokedex.length,
        shrinkWrap: true,
        padding: const EdgeInsets.all(5),
        scrollDirection: Axis.vertical,
      ),
    );
  }

  Item createItem(List<Pokemon> pokemons, List<int> indexes) {
    Pokemon pokemon = pokemons.current(indexes);
    Game tempGame =
        Game(name: "Unknown", dex: "", number: "", notes: "", shinyLocked: "");
    Item item = Item.fromDex(pokemon, tempGame, kCollectionKey);
    item.currentLocation = "Unknown";
    item.catchDate = DateTime.now().toString();
    return item;
  }

  Future<void> saveImage(Uint8List bytes) async {}

  String getSubTitle(displayType) {
    switch (displayType) {
      case CollectionDisplayType.groupByCurrentGame:
        return "(By Current Game)";
      case CollectionDisplayType.groupByOriginalGame:
        return "(By Origin Game)";
      case CollectionDisplayType.groupByPokemon:
        return "(By Pokemon)";
      default:
        return "";
    }
  }
}
