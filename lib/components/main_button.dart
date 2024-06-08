import 'package:flutter/material.dart';
import 'package:oaks_legacy/utils/colors.dart';
import 'package:oaks_legacy/utils/functions.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
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
    double width =
        getButtonWidth(MediaQuery.of(context).size.width, [300, 350, 500, 700]);
    double height =
        width * ((MediaQuery.of(context).size.height > 1000) ? 0.35 : 0.25);

    return ZoomTapAnimation(
      child: GestureDetector(
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
            // color: const Color(0xFF1D1E33),
            boxShadow: [
              BoxShadow(
                color: cCardShadowColor,
                blurRadius: 5,
                spreadRadius: 0.5,
                offset: const Offset(3, 3),
              ),
            ],
          ),
          width: width,
          height: height,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            color: cCardMainColor,
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
                          style: TextStyle(
                              color: cTitleColor,
                              fontSize: 40,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        subtitle,
                        style: TextStyle(
                          color: cSubTitleColor,
                          fontSize: (height / 10) + 5,
                          fontStyle: FontStyle.italic,
                        ),
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
