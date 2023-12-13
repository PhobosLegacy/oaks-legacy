import 'package:flutter/material.dart';
import '../constants.dart';

class MainScreenButton extends StatelessWidget {
  const MainScreenButton(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.image,
      required this.screen});

  final String title;
  final String subtitle;
  final String image;
  final Widget screen;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.width > 600 ? 200 : 100;
    double widght = MediaQuery.of(context).size.width > 600 ? 500 : 400;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return screen;
            },
          ),
        );
      },
      child: Container(
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
        width: widght,
        height: height,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          color: const Color(0xFF1D1E33),
          elevation: 10,
          child: Row(children: [
            Image.network(kImageLocalPrefix + image, height: height),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        title,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      subtitle,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 20,
                        fontStyle: FontStyle.italic,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
