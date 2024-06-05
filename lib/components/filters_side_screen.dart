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
    return SizedBox(
      width: 600,
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            SizedBox(
              height: 80,
              child: DrawerHeader(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Filters',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                      ),
                    ),
                    IconButton(
                      onPressed: onClose,
                      icon: const Icon(
                        Icons.close,
                        color: Colors.red,
                        size: 30,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Column(
              children: [...filters],
            ),
          ],
        ),
      ),
    );
  }
}
