import 'package:flutter/material.dart';

class FiltersSideScreen extends StatelessWidget {
  const FiltersSideScreen({
    required this.filters,
    required this.onClose,
    super.key,
  });

  final List<Widget> filters;
  final Function() onClose;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.blueGrey[900],
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: 80,
            child: DrawerHeader(
              decoration: BoxDecoration(color: Colors.blueGrey[800]),
              child: const Text(
                'Filters',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Column(
            children: [...filters],
          ),
          const Divider(thickness: 2),
          Center(
            child: TextButton(
              onPressed: onClose,
              style: ButtonStyle(
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                foregroundColor: MaterialStateProperty.resolveWith<Color?>(
                  (Set<MaterialState> states) {
                    return Colors.amber;
                  },
                ),
                backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                  (Set<MaterialState> states) {
                    return Colors.blueGrey[800];
                  },
                ),
                overlayColor: MaterialStateProperty.resolveWith<Color?>(
                  (Set<MaterialState> states) {
                    return Colors.amber[800];
                  },
                ),
              ),
              child: const Text(
                "Close",
                // style: TextStyle(color: Colors.amber),
              ),
            ),
          )
        ],
      ),
    );
  }
}
