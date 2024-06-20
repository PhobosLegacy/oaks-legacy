import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:oaks_legacy/components/pkm_grid.dart';

class PkmDropDown extends StatelessWidget {
  PkmDropDown({
    super.key,
    required this.value,
    required this.onTap,
    required this.items,
    required this.hintText,
    this.enableSearch = false,
  });

  final TextEditingController textEditingController = TextEditingController();
  final String value;
  final Function(String) onTap;
  final List<DropdownMenuItem<String>> items;
  final String hintText;
  final bool enableSearch;

  @override
  Widget build(BuildContext context) {
    bool isMobile = PkmGrid.getCardsPerRow(context) == 1;
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Center(
        child: Material(
          color: Colors.transparent,
          child: DropdownButtonHideUnderline(
            child: DropdownButton2<String>(
              isExpanded: true,
              hint: Center(
                child: Text(
                  hintText,
                  style: TextStyle(
                    fontSize: 20,
                    color: (items.isEmpty) ? Colors.grey : Colors.amber,
                  ),
                ),
              ),
              buttonStyleData: ButtonStyleData(
                height: (isMobile) ? 55 : 65,
                width: (isMobile) ? 300 : 400,
                padding: const EdgeInsets.only(left: 14, right: 14),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: Colors.amber,
                  ),
                  //color: Colors.black12,
                  color: const Color(0xFF1D1E33),
                ),
                elevation: 2,
              ),
              items: items,
              value: (value.isEmpty) ? null : value,
              onChanged: (selected) {
                onTap(selected!);
              },
              iconStyleData: const IconStyleData(
                iconSize: 30,
                iconEnabledColor: Colors.amber,
                iconDisabledColor: Colors.grey,
              ),

              //Style of the List Item
              dropdownStyleData: DropdownStyleData(
                maxHeight: (isMobile) ? 300 : 500, //Height of the list
                width: (isMobile) ? 300 : 400, //Width of the list
                // offset: const Offset(-50, 0), //To centralize the list
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  color: const Color(0xFF1D1E33),
                ),
                scrollbarTheme: ScrollbarThemeData(
                  thumbColor: const WidgetStatePropertyAll(Colors.red),
                  radius: const Radius.circular(40),
                  thickness: WidgetStateProperty.all(6),
                  thumbVisibility: WidgetStateProperty.all(true),
                ),
              ),
              menuItemStyleData: const MenuItemStyleData(
                height: 80,
                overlayColor: WidgetStatePropertyAll(Colors.green),
              ),

              dropdownSearchData: (enableSearch)
                  ? DropdownSearchData(
                      searchController: textEditingController,
                      searchInnerWidgetHeight: 50,
                      searchInnerWidget: Container(
                        height: 50,
                        padding: const EdgeInsets.only(
                          top: 8,
                          bottom: 4,
                          right: 8,
                          left: 8,
                        ),
                        child: TextFormField(
                          expands: false,
                          minLines: 1,
                          maxLines: 1,
                          controller: textEditingController,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 8,
                            ),
                            hintText: '...or search for it',
                            hintStyle: const TextStyle(
                              fontSize: 18,
                              color: Colors.white60,
                              fontStyle: FontStyle.italic,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.amber,
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.amber,
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            errorBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.red,
                              ),
                            ),
                            focusedErrorBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.orange,
                              ),
                            ),
                          ),
                        ),
                      ),
                      searchMatchFn: (item, searchValue) {
                        return item.value.toString().contains(searchValue);
                      },
                    )
                  : null,
              //This to clear the search value when you close the menu
              onMenuStateChange: (isOpen) {
                if (!isOpen) {
                  textEditingController.clear();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
