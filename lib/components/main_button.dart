import 'package:flutter/material.dart';
import '../constants.dart';

class MainScreenButton extends StatelessWidget {
  const MainScreenButton(
      {super.key,
      required this.name,
      required this.image,
      required this.screen});

  final String name;
  final String image;
  final Widget screen;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color(0xFF1D1E33),
        boxShadow: const [
          BoxShadow(
            color: Colors.white,
            blurRadius: 0.5,
            spreadRadius: 0.5,
            offset: Offset(2, 3),
          ),
        ],
      ),
      child: TextButton(
        style: TextButton.styleFrom(
          foregroundColor: Colors.blueGrey,
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return screen;
              },
            ),
          );
        },
        child: Column(
          children: [
            // Image.asset("images/$image", height: 100),
            Image.network(kImageLocalPrefix + image, height: 100),
            SizedBox(
              width: 100,
              child: FittedBox(
                child: Text(
                  name,
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
