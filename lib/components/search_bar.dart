import 'package:flutter/material.dart';

class Search extends StatelessWidget {
  const Search(
      {super.key,
      required this.editingController,
      required this.isSearchOpened,
      required this.onCloseTap,
      required this.onValueChange});

  final Function() onCloseTap;
  final Function(String) onValueChange;
  final bool isSearchOpened;
  final TextEditingController editingController;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isSearchOpened,
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                style: const TextStyle(color: Colors.white),
                autofocus: true,
                onChanged: onValueChange,
                controller: editingController,
                decoration: InputDecoration(
                  hintStyle: const TextStyle(color: Colors.white),
                  labelStyle: const TextStyle(color: Colors.white),
                  labelText: "Search",
                  hintText: "Search",
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  suffixIcon: GestureDetector(
                    onTap: onCloseTap,
                    child: const Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: Colors.white),
                  ),
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.all(
                      Radius.circular(25.0),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
