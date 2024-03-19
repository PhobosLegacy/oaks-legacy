import 'package:flutter/material.dart';
import 'package:oaks_legacy/components/basic.dart';
import 'package:oaks_legacy/components/catch_card.dart';
import 'package:oaks_legacy/components/pkm_checkbox.dart';
import 'package:oaks_legacy/models/enums.dart';
import 'package:oaks_legacy/models/item.dart';

class AttributesDetailsBlock extends StatefulWidget {
  const AttributesDetailsBlock({
    super.key,
    required this.pokemon,
    required this.isEditMode,
    required this.editLocks,
  });

  final Item pokemon;
  final bool isEditMode;
  final List<DetailsLock>? editLocks;

  @override
  State<AttributesDetailsBlock> createState() => _AttributesDetailsBlockState();
}

class _AttributesDetailsBlockState extends State<AttributesDetailsBlock> {
  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    List<PokemonAttributes> attributes = [];
    if (widget.isEditMode) {
      attributes.addAll(PokemonAttributes.values);
    } else {
      attributes.addAll(PokemonAttributes.values
          .where((element) => widget.pokemon.attributes.contains(element)));
    }

    Widget mainContent = Visibility(
      visible: widget.pokemon.attributes.isNotEmpty || widget.isEditMode,
      child: Card(
        shape: (widget.isEditMode)
            ? RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: const BorderSide(color: Colors.yellow),
              )
            : null,
        color: Colors.black12,
        child: Column(
          children: [
            SingleChildScrollView(
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: ListTile(
                      tileColor: Colors.black12,
                      title: Center(
                        child: Text(
                          attributes[index].getAttributeName(),
                          style: const TextStyle(
                              color: Colors.white, fontSize: 20),
                        ),
                      ),
                      trailing: (widget.isEditMode)
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                  PkmCheckbox(
                                      value: widget.pokemon.attributes
                                          .contains(attributes[index]),
                                      onChanged: (change) {
                                        setState(() {
                                          if (change == false) {
                                            widget.pokemon.attributes
                                                .remove(attributes[index]);
                                          } else {
                                            widget.pokemon.attributes
                                                .add(attributes[index]);
                                          }
                                        });
                                      },
                                      scale: true)
                                ])
                          : null,
                    ),
                  );
                },
                itemCount: attributes.length,
                padding: const EdgeInsets.all(5),
                scrollDirection: Axis.vertical,
              ),
            ),
          ],
        ),
      ),
    );

    return (MediaQuery.of(context).size.width < 1024)
        ? mainContent
        : DetailsCard(cardChild: mainContent, blockTitle: "Attributes");
  }

  bool checkLocks(DetailsLock lockType) {
    if (widget.editLocks == null) return widget.isEditMode;
    if (widget.editLocks!.contains(lockType)) {
      return false;
    }
    return widget.isEditMode;
  }

  bool isAttibuteLocked(PokemonAttributes attibute) {
    switch (attibute) {
      case PokemonAttributes.isAlpha:
        return widget.editLocks!.contains(DetailsLock.attributesAlpha);
      case PokemonAttributes.isShiny:
        return widget.editLocks!.contains(DetailsLock.attributesShiny);
      default:
        return false;
    }
  }
}
