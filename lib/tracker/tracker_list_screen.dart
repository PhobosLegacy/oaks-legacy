import 'package:flutter/material.dart';
import 'package:oaks_legacy/components/base_background.dart';
import 'package:oaks_legacy/components/pkm_grid.dart';
import 'package:oaks_legacy/models/game.dart';
import 'package:oaks_legacy/tracker/tracker_tiles.dart';
import '../components/app_bar.dart';
import '../components/filter_by_type.dart';
import '../components/filters_side_screen.dart';
import '../components/import_collection_button.dart';
import '../components/search_bar.dart';
import '../components/switch_option.dart';
import '../components/sort_list_by.dart';
import '../models/tracker.dart';
import '../models/enums.dart';
import '../models/item.dart';
import '../utils/trackers_manager.dart';

class TrackerListScreen extends StatefulWidget {
  const TrackerListScreen({
    super.key,
    required this.collection,
    required this.callBackAction,
  });

  final Tracker collection;
  //VoidCallback: To ensure percentage is correct upon returning without having to refresh page
  final VoidCallback callBackAction;
  @override
  State<TrackerListScreen> createState() => _TrackerListScreenState();
}

class _TrackerListScreenState extends State<TrackerListScreen> {
  List<Item> filteredList = [];
  List<FilterType> filters = [];
  String searchQuery = "";
  int _selectedIndex = 0;
  bool _exclusiveOnly = false;
  bool _isSearchOpened = false;
  List<String> _drawerByTypesSelected = [];
  TextEditingController editingController = TextEditingController();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    filteredList.addAll(widget.collection.pokemons.toList());
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
            Text(
              widget.collection.game,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              widget.collection.dex,
              style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic),
            ),
            Text(
              "(${widget.collection.percentage()}%)",
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        color: Game.gameColor(widget.collection.game),
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
                Expanded(
                  child: PkmGrid(
                    itemBuilder: (context, index) {
                      return TrackerTile(
                        pokemons: filteredList,
                        indexes: [index],
                        isLowerTile: false,
                        onStateChange: () {
                          setState(() {
                            saveTracker(widget.collection);
                            applyFilters();
                            widget.callBackAction();
                          });
                        },
                      );
                    },
                    itemCount: filteredList.length,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        backgroundColor: Game.gameColor(widget.collection.game),
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.white,
        items: <BottomNavigationBarItem>[
          const BottomNavigationBarItem(
            icon: Icon(Icons.check_circle_outline_outlined),
            label: "All",
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.check_box_outlined),
            label:
                "${widget.collection.capturedTotal()}/${widget.collection.total()}",
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.check_box_outline_blank),
            label:
                "${widget.collection.missingTotal()}/${widget.collection.total()}",
          ),
        ],
        onTap: (int index) {
          setState(
            () {
              switch (index) {
                case 0:
                  removeFilters([FilterType.captured, FilterType.notCaptured]);
                  break;
                case 1:
                  removeFilters([FilterType.notCaptured]);
                  addFilter(FilterType.captured);
                  break;
                case 2:
                  removeFilters([FilterType.captured]);
                  addFilter(FilterType.notCaptured);
                  break;
              }
              _selectedIndex = index;
              applyFilters();
            },
          );
        },
      ),
    );
  }

  void applyFilters() {
    setState(() {
      (searchQuery == "")
          ? removeFilters([FilterType.byValue])
          : addFilter(FilterType.byValue);

      filteredList = widget.collection
          .applyAllFilters(filters, searchQuery, _drawerByTypesSelected);
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
      IconButton(
        icon: const Icon(Icons.search_outlined),
        onPressed: () {
          setState(() {
            _isSearchOpened = !_isSearchOpened;
          });
        },
      ),
      IconButton(
        icon: const Icon(Icons.filter_alt_outlined),
        onPressed: () {
          setState(() {
            scaffoldKey.currentState!.openEndDrawer();
          });
        },
      ),
    ];
  }

  List<Widget> trackerFilters() {
    return [
      const Divider(thickness: 2),
      SwitchOption(
        title: "Show Exclusive Only",
        switchValue: _exclusiveOnly,
        onSwitch: (bool value) {
          setState(() {
            _exclusiveOnly = value;
            (_exclusiveOnly)
                ? addFilter(FilterType.exclusiveOnly)
                : removeFilters([FilterType.exclusiveOnly]);
            applyFilters();
          });
        },
      ),
      const Divider(thickness: 2),
      FilterByType(
        selectedTypes: _drawerByTypesSelected,
        onTypeSelected: (List<String> list) {
          setState(
            () {
              _drawerByTypesSelected = list;
              (_drawerByTypesSelected.isEmpty)
                  ? removeFilters([FilterType.byType])
                  : addFilter(FilterType.byType);
              applyFilters();
            },
          );
        },
        onClearPressed: () {
          setState(() {
            _drawerByTypesSelected.clear();
            removeFilters([FilterType.byType]);
            applyFilters();
          });
        },
      ),
      const Divider(thickness: 2),
      SortListBy(
        onFilterSelected: (filter) {
          setState(() {
            removeFilters([
              FilterType.numAsc,
              FilterType.numDesc,
              FilterType.nameAsc,
              FilterType.nameDesc
            ]);
            addFilter(filter);
            applyFilters();
          });
        },
      ),
      const Divider(thickness: 2),
      ImportToCollectionButton(
        listToImport: filteredList
            .where((element) =>
                Tracker.isPokemonCaptured(element) == CaptureType.full ||
                Tracker.isPokemonCaptured(element) == CaptureType.partial)
            .toList(),
      )
    ];
  }
}
