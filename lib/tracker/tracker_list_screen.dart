import 'package:flutter/material.dart';
import 'package:oaks_legacy/components/base_background.dart';
import 'package:oaks_legacy/components/pkm_grid.dart';
import 'package:oaks_legacy/models/game.dart';
import 'package:oaks_legacy/tracker/tracker_tiles.dart';
import 'package:screenshot/screenshot.dart';
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
// import 'package:image/image.dart' as img;

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
  bool _flatList = false;
  bool _isSearchOpened = false;
  List<String> _drawerByTypesSelected = [];
  TextEditingController editingController = TextEditingController();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final controller = ScreenshotController();

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
        title: getAppBarTitleWidget(),
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
                        trackerInfo: widget.collection.trackerInfo(),
                        indexes: [index],
                        isLowerTile: false,
                        onStateChange: () async {
                          await saveTracker(widget.collection);
                          setState(() {
                            applyFilters();
                          });
                          widget.callBackAction();
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

  getAppBarTitleWidget() {
    bool isSmall = (PkmGrid.getCardsPerRow(context) == 1);

    final gameText = Text(
      widget.collection.game,
      style: TextStyle(
        fontSize: (isSmall) ? 15 : 40,
        fontWeight: FontWeight.bold,
        fontStyle: (isSmall) ? null : FontStyle.italic,
      ),
    );

    final dexText = Text(
      '${widget.collection.dex} Dex',
      style: TextStyle(
        fontSize: (isSmall) ? 10 : 20,
        fontWeight: FontWeight.bold,
        fontStyle: (isSmall) ? null : FontStyle.italic,
      ),
    );

    final percentageText = Text(
      "(${widget.collection.percentage()}%)",
      style: TextStyle(
        fontSize: (isSmall) ? 15 : 20,
        fontWeight: FontWeight.bold,
      ),
    );

    if (PkmGrid.getCardsPerRow(context) > 1) {
      return Row(
        children: [
          gameText,
          const SizedBox(width: 20),
          Column(
            children: [
              dexText,
              percentageText,
            ],
          ),
        ],
      );
    }

    return Column(
      children: [gameText, dexText, percentageText],
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
      //For this to work you need:
      //Expanded(
      // child: SingleChildScrollView(
      //   child: Screenshot(
      //     controller: controller,
      //     child: PkmGrid(
      //if (kFlags.screenshot)
      //   IconButton(
      //       icon: const Icon(Icons.camera),
      //       onPressed: () async {
      //         int cardsPerRow = PkmGrid.getCardsPerRow(context);
      //         var otro = 99 ~/ cardsPerRow;
      //         List<Item> original = List<Item>.from(filteredList);
      //         List<Uint8List?> images = List<Uint8List?>.empty(growable: true);

      //         for (var i = 0; i < original.length; i) {
      //           var limit = ((i + otro * cardsPerRow) > filteredList.length)
      //               ? filteredList.length
      //               : i + otro * cardsPerRow;

      //           filteredList = original.sublist(i, limit);
      //           setState(() {});
      //           Uint8List? snapshot = await snap();
      //           if (snapshot != null) images.add(snapshot);
      //           i = limit;
      //           filteredList.clear();
      //           filteredList.addAll(original);
      //         }
      //         setState(() {});

      //         List<img.Image> lista = List<img.Image>.empty(growable: true);
      //         int totalHeight = 0;
      //         int maxWidth = 0;
      //         for (Uint8List? image in images) {
      //           lista.add(img.decodeImage(image as List<int>)!);
      //           totalHeight += lista.last.height;
      //         }
      //         maxWidth = lista.last.width;
      //         img.Image mergedImage = img.Image(maxWidth, totalHeight);

      //         for (var i = 0; i < lista.length; i++) {
      //           if (i == 0)
      //             img.copyInto(mergedImage, lista[0], dstX: 0, dstY: 0);

      //           img.copyInto(mergedImage, lista[i],
      //               dstX: 0, dstY: getHeight(lista, i));
      //         }
      //         Uint8List mergedImageBytes =
      //             Uint8List.fromList(img.encodePng(mergedImage));

      //         final time = DateTime.now()
      //             .toIso8601String()
      //             .replaceAll('.', '-')
      //             .replaceAll(':', '-');

      //         final name = 'pk_$time';

      //         FileSaver.instance
      //             .saveFile(name: '$name.png', bytes: mergedImageBytes);
      //       }),
      // ScreenShotButton(
      //   screenshotController: controller,
      //   shouldTrim: filteredList.length < PkmGrid.getCardsPerRow(context),
      // ),
    ];
  }

  // getHeight(List<img.Image> lista, index) {
  //   int height = 0;
  //   for (var i = 0; i < index; i++) {
  //     height += lista[i].height;
  //   }
  //   return height;
  // }

  // Future<Uint8List?> snap() async {
  //   try {
  //     return await controller.capture(delay: const Duration(seconds: 3));
  //   } catch (err) {
  //     if (context.mounted) showSnackbar(context, err.toString());
  //   }
  //   return null;
  // }

  List<Widget> trackerFilters() {
    return [
      const Divider(thickness: 2),
      SwitchOption(
        title: "Show Exclusive Only",
        switchValue: _exclusiveOnly,
        onSwitch: (bool value1) {
          setState(() {
            _exclusiveOnly = value1;
            (_exclusiveOnly)
                ? addFilter(FilterType.exclusiveOnly)
                : removeFilters([FilterType.exclusiveOnly]);
            applyFilters();
          });
        },
      ),
      if (widget.collection.pokemons.any((element) => element.forms.isNotEmpty))
        const Divider(thickness: 2),
      if (widget.collection.pokemons.any((element) => element.forms.isNotEmpty))
        SwitchOption(
          title: "Single List",
          switchValue: _flatList,
          onSwitch: (bool value2) {
            setState(() {
              _flatList = value2;
              (_flatList)
                  ? addFilter(FilterType.flatList)
                  : removeFilters([FilterType.flatList]);
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
