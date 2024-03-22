import 'package:flutter/material.dart';
import 'package:oaks_legacy/components/base_background.dart';
import 'package:oaks_legacy/components/button_filters.dart';
import 'package:oaks_legacy/components/button_search.dart';
import 'package:oaks_legacy/components/pkm_grid.dart';
import 'package:oaks_legacy/pokedex/pokedex_tiles.dart';
import '../components/app_bar.dart';
import '../components/filters_side_screen.dart';
import '../components/search_bar.dart';
import '../components/filter_by_type.dart';
import '../components/sort_list_by.dart';
import '../models/enums.dart';
import '../models/pokemon.dart';

class PokedexListScreen extends StatefulWidget {
  const PokedexListScreen({
    super.key,
    required this.pokemons,
  });

  final List<Pokemon> pokemons;
  @override
  State<PokedexListScreen> createState() => _PokedexListScreenState();
}

class _PokedexListScreenState extends State<PokedexListScreen> {
  String searchQuery = "";
  bool isSearchOpened = false;

  List<FilterType> filters = [];
  List<String> typesSelected = [];
  List<Pokemon> originalPokedex = [];

  ScrollController scrollController = ScrollController();
  TextEditingController editingController = TextEditingController();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    originalPokedex.addAll(widget.pokemons);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: scaffoldKey,
      appBar: AppBarBase(
        title: const Text(
          "Pokedex",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        color: Colors.blueGrey[800],
        actions: appBarActions(),
      ),
      endDrawer: FiltersSideScreen(
        filters: pokedexFilters(),
        onClose: () {
          setState(() => scaffoldKey.currentState!.closeEndDrawer());
        },
      ),
      body: Stack(
        children: [
          const BaseBackground(),
          SafeArea(
            child: Column(
              children: [
                Search(
                  isSearchOpened: isSearchOpened,
                  editingController: editingController,
                  onCloseTap: () => {
                    setState(
                      () {
                        (editingController.text == "")
                            ? isSearchOpened = false
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
                //POKEMON LIST
                Expanded(
                  child: PkmGrid(
                    itemCount: originalPokedex.length,
                    itemBuilder: (context, index) {
                      return PokemonTiles(
                        isLowerTile: false,
                        pokemons: originalPokedex,
                        indexes: [index],
                      );
                    },
                  ),
                ),
                // PokedexList(
                //   pokemons: originalPokedex,
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void applyFilters() {
    setState(() {
      (searchQuery == "")
          ? removeFilters([FilterType.byValue])
          : addFilter(FilterType.byValue);
      originalPokedex =
          widget.pokemons.applyAllFilters(filters, searchQuery, typesSelected);
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
            isSearchOpened = !isSearchOpened;
          });
        },
      ),
      FiltersButton(scaffoldKey: scaffoldKey),
    ];
  }

  List<Widget> pokedexFilters() {
    return [
      const Divider(thickness: 2),
      FilterByType(
        selectedTypes: typesSelected,
        onTypeSelected: (List<String> list) {
          setState(
            () {
              typesSelected = list;
              (typesSelected.isEmpty)
                  ? removeFilters([FilterType.byType])
                  : addFilter(FilterType.byType);
              applyFilters();
            },
          );
        },
        onClearPressed: () {
          setState(() {
            typesSelected.clear();
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
    ];
  }
}
