import 'package:flutter/material.dart';
import 'package:oaks_legacy/components/pkm_scrollbar.dart';
import 'package:oaks_legacy/components/pkm_grid.dart';
import 'package:oaks_legacy/components/pkm_text_dialog.dart';
import 'package:oaks_legacy/constants.dart';
import 'package:oaks_legacy/custom_tracker/custom_tracker_tile.dart';
import 'package:oaks_legacy/models/tracker.dart';
import 'package:oaks_legacy/pokedex/pokedex_tiles.dart';
import 'package:oaks_legacy/utils/trackers_manager.dart';
import 'package:screenshot/screenshot.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../components/app_bar.dart';
import '../components/base_background.dart';
import '../components/button_search.dart';
import '../components/search_bar.dart';
import '../models/enums.dart';
import '../models/group.dart';
import '../models/item.dart';
import '../models/pokemon.dart';
import '../utils/items_manager.dart';

class CustomTrackerScreen extends StatefulWidget {
  final String screenKey = '';
  final Tracker tracker;
  final Function(Tracker) onTrackerCreation;
  const CustomTrackerScreen({
    required this.tracker,
    required this.onTrackerCreation,
    super.key,
  });

  @override
  State<CustomTrackerScreen> createState() => _CustomTrackerScreenState();
}

class _CustomTrackerScreenState extends State<CustomTrackerScreen> {
  final controller = ScreenshotController();
  final gscrollController = ScrollController();
  String searchQuery = "";
  int _selectedTab = 0;
  bool _isSearchOpened = false;
  CollectionDisplayType displayType = CollectionDisplayType.flatList;
  List<Item> collection = [];
  List<FilterType> filters = [];
  TextEditingController editingController = TextEditingController();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  bool _dataLoaded = false;
  List<Pokemon> originalPokedex = [];
  List<Item> filteredAllItems = [];
  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    textEditingController.text = widget.tracker.name;

    setState(() {
      collection = widget.tracker.pokemons;
      _dataLoaded = true;
    });

    originalPokedex.addAll(kPokedex.asFlatList());
    widget.tracker.pokemons.add(
        Item.createPlaceholderItem([7], widget.screenKey, originalPokedex));
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
        title: ZoomTapAnimation(
          child: GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                barrierColor: Colors.black87,
                builder: (BuildContext otContext) {
                  textEditingController.text = widget.tracker.name;
                  return PkmTextEditDialog(
                    title: 'Change Name',
                    textController: textEditingController,
                    onChange: () {
                      setState(() {
                        widget.tracker.name = textEditingController.text;
                      });
                    },
                  );
                },
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${widget.tracker.name} ',
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
                const Icon(
                  Icons.edit,
                  color: Colors.white,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
        actions: appBarActions(),
      ),
      // endDrawer: FiltersSideScreen(
      //   filters: trackerFilters(),
      //   onClose: () {
      //     setState(() => scaffoldKey.currentState!.closeEndDrawer());
      //   },
      // ),
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
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "You have no Pokemon in your tracker.",
                                    style: TextStyle(
                                      color: Colors.amber,
                                      fontSize: (isMobile) ? 15 : 30,
                                    ),
                                  ),
                                  Text(
                                    "Start by clicking on 'Add' below!",
                                    style: TextStyle(
                                      color: Colors.amber,
                                      fontSize: (isMobile) ? 15 : 30,
                                    ),
                                  ),
                                ],
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
    kPreferences.revealUncaught = true;
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
                return CustomTrackerTile(
                  isLowerTile: false,
                  pokemons: collection,
                  indexes: [index],
                  trackerInfo: widget.tracker.trackerInfo(),
                  onStateChange: (pokemon) {
                    setState(() {
                      widget.tracker.pokemons.remove(pokemon);
                    });
                  },
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
                                return CustomTrackerTile(
                                  isLowerTile: false,
                                  pokemons: collection,
                                  indexes: [index],
                                  trackerInfo: widget.tracker.trackerInfo(),
                                  onStateChange: (pokemon) {
                                    widget.tracker.pokemons.remove(pokemon);
                                    setState(() {});
                                  },
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

  void applyFilters() async {
    (searchQuery == "")
        ? removeFilters([FilterType.byValue])
        : addFilter(FilterType.byValue);

    collection = widget.tracker.pokemons;
    collection = collection.applyAllFilters(filters, searchQuery);

    originalPokedex =
        originalPokedex.applyAllFilters(filters, searchQuery, null, null);
    originalPokedex = originalPokedex.asFlatList();
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
    bool isMobile = PkmGrid.getCardsPerRow(context) == 1;

    if (isMobile) {
      return [
        SearchButton(
          onPressed: () {
            setState(() {
              _isSearchOpened = !_isSearchOpened;
            });
          },
        ),
        PopupMenuButton<String>(
          onSelected: (String result) {
            if (result == 'ShinyUp') {
              makeAllShiny();
            } else if (result == 'Save') {
              saveCustomTracker();
            }
          },
          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
            const PopupMenuItem<String>(
              value: 'ShinyUp',
              child: Text('Make it all shiny!'),
            ),
            const PopupMenuItem<String>(
              value: 'Save',
              child: Text('Save'),
            ),
          ],
          icon: const Icon(
            Icons.more_vert_outlined,
            size: 30,
          ),
        )
      ];
    }
    return [
      SearchButton(
        onPressed: () {
          setState(() {
            _isSearchOpened = !_isSearchOpened;
          });
        },
      ),
      Tooltip(
        message: 'Make it all shiny!',
        child: IconButton(
          icon: const Icon(Icons.auto_awesome),
          onPressed: () {
            makeAllShiny();
          },
        ),
      ),
      IconButton(
        icon: const Icon(Icons.save),
        onPressed: () {
          saveCustomTracker();
        },
      ),
    ];
  }

  makeAllShiny() {
    setState(() {
      for (var i = 0; i < widget.tracker.pokemons.length; i++) {
        Item pkm = widget.tracker.pokemons[i];
        if (!pkm.attributes.contains(PokemonAttributes.isShiny)) {
          pkm.attributes.add(PokemonAttributes.isShiny);
        }
        pkm.displayImage = pkm.updateDisplayImage();
      }
    });
  }

  saveCustomTracker() async {
    await saveTracker(widget.tracker);
    widget.onTrackerCreation(widget.tracker);
  }

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
              Item item = Item.createPlaceholderItem(
                  indexes, widget.screenKey, originalPokedex);
              widget.tracker.pokemons.add(item);
              collection = widget.tracker.pokemons;
              setState(() {});
            },
            button1Icon: Text(
              widget.tracker.pokemons
                  .where(
                    (element) =>
                        element.ref.substring(0, element.ref.indexOf('_')) ==
                        originalPokedex[index].ref,
                  )
                  .toList()
                  .length
                  .toString(),
              style: const TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          );
        },
      ),
    );
  }
}
