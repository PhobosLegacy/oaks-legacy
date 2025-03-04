import 'package:flutter/material.dart';
import 'package:oaks_legacy/components/pkm_scrollbar.dart';
import 'package:oaks_legacy/components/pkm_grid.dart';
import 'package:oaks_legacy/constants.dart';
import 'package:oaks_legacy/item/item_tile.dart';
import 'package:oaks_legacy/models/game.dart';
import 'package:oaks_legacy/pokedex/pokedex_tiles.dart';
import 'package:oaks_legacy/tracker/tracker_details_screen.dart';
import 'package:oaks_legacy/utils/enum_manager.dart';
import 'package:oaks_legacy/utils/functions.dart';
import 'package:screenshot/screenshot.dart';
import '../components/app_bar.dart';
import '../components/base_background.dart';
import '../components/button_filters.dart';
import '../components/button_search.dart';
import '../components/button_screenshot.dart';
import '../components/filters_side_screen.dart';
import '../components/group_list_by.dart';
import '../components/search_bar.dart';
import '../models/enums.dart';
import '../models/group.dart';
import '../models/item.dart';
import '../models/pokemon.dart';
import '../utils/items_manager.dart';

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
  final gscrollController = ScrollController();
  String searchQuery = "";
  int _selectedTab = 0;
  bool _isSearchOpened = false;
  CollectionDisplayType displayType = CollectionDisplayType.flatList;
  List<Item> collection = [];
  List<Pokemon> originalPokedex = [];
  List<FilterType> filters = [];
  TextEditingController editingController = TextEditingController();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  bool _dataLoaded = false;

  @override
  void initState() {
    originalPokedex.addAll(kPokedex);
    retrieveItems(widget.screenKey).then((data) {
      setState(() {
        collection = data;
        _dataLoaded = true;
      });
    });
    super.initState();
    // Schedule the openEndDrawer call after the first frame is rendered
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   scaffoldKey.currentState?.openEndDrawer();
    // });
  }

  @override
  Widget build(BuildContext context) {
    bool isMobile = PkmGrid.getCardsPerRow(context) == 1;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: scaffoldKey,
      appBar: AppBarBase(
        title: Column(
          children: [
            Text(
              widget.title,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
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
                _dataLoaded
                    ? (_selectedTab == 0 && collection.isEmpty)
                        ? Expanded(
                            child: Center(
                              child: Text(
                                getEmptyListMessage(widget.screenKey),
                                style: TextStyle(
                                  color: Colors.amber,
                                  fontSize: (isMobile) ? 15 : 30,
                                ),
                              ),
                            ),
                          )
                        : (_selectedTab == 0 && collection.isNotEmpty)
                            ? collectionList()
                            : pokedex()
                    : const CircularProgressIndicator()
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
        backgroundColor: Colors.black26,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.blueGrey[300]!,
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

    return (CollectionDisplayType.flatList == displayType)
        // FLAT LIST
        ? Expanded(
            child: PkmGrid(
              itemBuilder: (context, index) {
                return ItemTile(
                  pokemons: collection,
                  isLowerTile: false,
                  indexes: [index],
                  onStateChange: (item) {
                    setState(() {
                      saveToCollection(item);
                    });
                    showSnackbar(context, '${item.name} updated.');
                  },
                  onDelete: (item) async {
                    await removeFromColletion(item);
                  },
                  screenKey: widget.screenKey,
                );
              },
              itemCount: collection.length,
            ),
          )
        //GROUPED
        : Expanded(
            child: PkmScrollbar(
              scrollController: gscrollController,
              child: SingleChildScrollView(
                controller: gscrollController,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    ...groups.map((group) {
                      return SizedBox(
                        height: (group.items.length /
                                    PkmGrid.getCardsPerRow(context))
                                .ceil() *
                            270,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 50,
                              child: Text(
                                group.name,
                                style: const TextStyle(
                                  fontSize: 35,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            PkmGrid(
                              itemBuilder: (context, index) {
                                return ItemTile(
                                  pokemons: group.items,
                                  isLowerTile: false,
                                  indexes: [index],
                                  onStateChange: (item) {
                                    setState(() {
                                      saveToCollection(item);
                                    });
                                    showSnackbar(
                                        context, '${item.name} updated.');
                                  },
                                  onDelete: (item) async {
                                    await removeFromColletion(item);
                                  },
                                  screenKey: widget.screenKey,
                                );
                              },
                              itemCount: group.items.length,
                            ),
                          ],
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
          );
  }

  Future removeFromColletion(Item item) async {
    collection = await retrieveItems(widget.screenKey);
    collection.removeWhere((element) => element.ref == item.ref);
    saveItems(widget.screenKey, collection);
    collection = collection.applyAllFilters(filters, searchQuery);
    setState(() {});
  }

  void saveToCollection(Item item) async {
    item.displayImage = item.updateDisplayImage();
    collection = await retrieveItems(widget.screenKey);
    final index = collection.indexWhere((element) => element.ref == item.ref);
    if (index == -1) {
      collection.add(item);
    } else {
      collection[index] = item;
    }
    saveItems(widget.screenKey, collection);
    collection = collection.applyAllFilters(filters, searchQuery);
  }

  void applyFilters() async {
    (searchQuery == "")
        ? removeFilters([FilterType.byValue])
        : addFilter(FilterType.byValue);

    collection = await retrieveItems(widget.screenKey);
    collection = collection.applyAllFilters(filters, searchQuery);

    originalPokedex =
        originalPokedex.applyAllFilters(filters, searchQuery, null, null);
    setState(() {});
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
      if (_selectedTab == 0 && kFlags.screenshot)
        ScreenShotButton(
          screenshotController: controller,
          shouldTrim: collection.length < PkmGrid.getCardsPerRow(context),
        ),
      if (_selectedTab == 0) FiltersButton(scaffoldKey: scaffoldKey),
    ];
  }

  List<Widget> trackerFilters() {
    return [
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
    return Expanded(
      child: PkmGrid(
        itemCount: originalPokedex.length,
        itemBuilder: (context, index) {
          return PokemonTiles(
            isLowerTile: false,
            // pokemons: originalPokedex.take(data.length).toList(),
            pokemons: originalPokedex,
            indexes: [index],
            onTapOverride: (indexes) {
              setState(() {
                List<Item> items = [
                  createPlaceholderItem(
                      indexes, widget.screenKey, originalPokedex)
                ];
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return TrackerDetailsPage(
                        pokemons: items,
                        indexes: const [0],
                        onStateChange: () {
                          setState(() {
                            saveToCollection(items.current([0]));
                          });
                          showSnackbar(context, '${items[0].name} added.');
                        },
                      );
                    },
                  ),
                );
              });
            },
            button1Icon: const Icon(
              Icons.add_box_outlined,
              color: Colors.amber,
            ),
            button1OnPressed: (pokemon) => {
              saveToCollection(
                createPlaceholderItem([0], widget.screenKey, [pokemon]),
              ),
              showSnackbar(context, '${pokemon.name} added.'),
            },
            // button2Icon: const Icon(Icons.edit_square, color: Colors.amber),
            // button2OnPressed: (pokemon) => {print(pokemon.number)},
          );
        },
      ),
    );
  }

  Item createPlaceholderItem(
      List<int> indexes, String origin, List<Pokemon> pokemons) {
    Pokemon pokemon = pokemons.current(indexes);
    Game tempGame =
        Game(name: "Unknown", dex: "", number: "", notes: "", shinyLocked: "");
    Item item = Item.fromDex(pokemon, tempGame, origin);
    item.currentLocation = "Unknown";
    item.catchDate = DateTime.now().toString();
    return item;
  }

  String getEmptyListMessage(screenKey) {
    switch (screenKey) {
      case kCollectionKey:
        return "You have no Pokemon in your collection";
      case kLookingFor:
        return "You have no Pokemon in your list. Try adding some!";
      case kForTrade:
        return "You have no Pokemon in your list. Try adding some!";
      default:
        return "You have no items in your collection";
    }
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
      : super(
          screenKey: kForTrade,
          title: 'For Trade',
        );
}
