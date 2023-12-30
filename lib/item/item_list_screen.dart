import 'package:flutter/material.dart';
import 'package:oaks_legacy/constants.dart';
import 'package:oaks_legacy/item/item_details_screen.dart';
import 'package:oaks_legacy/item/item_tile.dart';
import 'package:oaks_legacy/utils/enum_manager.dart';
import 'package:screenshot/screenshot.dart';

import '../components/app_bar.dart';
import '../components/base_background.dart';
import '../components/button_filters.dart';
import '../components/button_search.dart';
import '../components/button_screenshot.dart';
import '../components/filters_side_screen.dart';
import '../components/group_list_by.dart';
import '../components/list_pokedex.dart';
import '../components/search_bar.dart';
import '../models/enums.dart';
import '../models/group.dart';
import '../models/item.dart';
import '../models/pokemon.dart';
import '../utils/items_manager.dart';
import 'item_expansion_tile.dart';

class BaseCollectionScreen extends StatefulWidget {
  final String screenKey;
  final String title;

  const BaseCollectionScreen({
    required this.screenKey,
    required this.title,
    super.key,
  });

  @override
  State<BaseCollectionScreen> createState() => _BaseCollectionScreenState();
}

class _BaseCollectionScreenState extends State<BaseCollectionScreen> {
  final controller = ScreenshotController();
  String searchQuery = "";
  int _selectedTab = 0;
  bool _isSearchOpened = false;
  CollectionDisplayType displayType = CollectionDisplayType.flatList;
  List<Item> collection = [];
  List<Pokemon> originalPokedex = [];
  List<FilterType> filters = [];
  TextEditingController editingController = TextEditingController();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    originalPokedex.addAll(kPokedex);
    collection = retrieveItems(widget.screenKey);
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
            Text(widget.title),
            if (displayType != CollectionDisplayType.flatList)
              Text(
                displayType.text(),
                style: const TextStyle(
                  fontSize: 10,
                  fontStyle: FontStyle.italic,
                ),
              ),
          ],
        ),
        color: Colors.blueGrey[800],
        actions: appBarActions(),
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
                        searchQuery = "";
                        applyFilters();
                      },
                    )
                  },
                  onValueChange: (value) {
                    searchQuery = value;
                    applyFilters();
                  },
                ),
                if (_selectedTab == 0 && collection.isEmpty)
                  const Expanded(
                    child: Center(
                      child: Text(
                        "You have no items in your collection",
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
            label: "My List",
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

  Widget collectionList() {
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
                  ? createTile(collection, index)
                  : createCards(groups[index]);
            }),
          ),
        ),
      ),
    );
  }

  Widget createTile(List<Item> items, int index) {
    // Common tile creation logic for each screen
    return ItemTile(
      pokemons: items,
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
    );
  }

  cards(Group groups) {
    return createCards(
      groups,
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
  }

  void removeFromColletion(Item item) {
    collection = retrieveItems(widget.screenKey);
    collection.removeWhere((element) => element.ref == item.ref);
    saveItems(widget.screenKey, collection);
    collection = collection.applyAllFilters(filters, searchQuery);
  }

  void saveToCollection(Item item) {
    collection = retrieveItems(widget.screenKey);
    final index = collection.indexWhere((element) => element.ref == item.ref);
    if (index == -1) {
      collection.add(item);
    } else {
      collection[index] = item;
    }
    saveItems(widget.screenKey, collection);
    collection = collection.applyAllFilters(filters, searchQuery);
  }

  void applyFilters() {
    setState(() {
      (searchQuery == "")
          ? removeFilters([FilterType.byValue])
          : addFilter(FilterType.byValue);

      collection = retrieveItems(widget.screenKey);
      collection = collection.applyAllFilters(filters, searchQuery);

      originalPokedex =
          originalPokedex.applyAllFilters(filters, searchQuery, null);
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

  // This is the Second Tab Bits
  pokedex() {
    return PokedexList(
      pokemons: originalPokedex,
      detailsKey: widget.screenKey,
      pageBuilder: (items, indexes) => ItemDetailsPage(
        pokemons: items,
        indexes: indexes,
        onStateChange: (item) {
          saveToCollection(item);
        },
      ),
    );
  }
}

class CollectionScreen extends BaseCollectionScreen {
  const CollectionScreen({super.key})
      : super(
          screenKey: kCollectionKey,
          title: 'My Collection',
        );
}

class LookingForScreen extends BaseCollectionScreen {
  const LookingForScreen({super.key})
      : super(
          screenKey: kLookingFor,
          title: 'Looking For',
        );
}

class ForTradeScreen extends BaseCollectionScreen {
  const ForTradeScreen({super.key})
      : super(screenKey: kForTrade, title: 'For Trade');
}
