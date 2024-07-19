import 'package:flutter/material.dart';
import 'package:oaks_legacy/components/pkm_grid.dart';
import 'package:oaks_legacy/constants.dart';
import 'package:oaks_legacy/utils/colors.dart';
import 'package:oaks_legacy/utils/extensions.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class PkmNewsIcon extends StatefulWidget {
  final String? resetCode;

  const PkmNewsIcon({
    super.key,
    this.resetCode,
  });

  @override
  State<PkmNewsIcon> createState() => _PkmNewsIconState();
}

class _PkmNewsIconState extends State<PkmNewsIcon>
    with TickerProviderStateMixin {
  bool isHovered = false;

  void onEntered(isHovering) {
    setState(() {
      isHovered = isHovering;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isMobile = PkmGrid.getCardsPerRow(context) == 1;
    double iconSize = (isMobile) ? 25 : 40;
    double textSize = (isMobile) ? 10 : 15;
    double width = (isMobile) ? MediaQuery.of(context).size.width - 25 : 600;
    double height = (isMobile) ? 300 : 350;
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ZoomTapAnimation(
        child: GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return Stack(
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: cCardShadowColor,
                                blurRadius: 5,
                                spreadRadius: 0.5,
                                offset: const Offset(3, 3),
                              ),
                            ],
                            color: cCardMainColor,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          width: width,
                          height: height,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "What's Up",
                                  style: TextStyle(
                                    color: cTitleColor,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: ListView.builder(
                                  itemCount: kNews
                                      .length, // Number of items in the list
                                  itemBuilder: (context, index) {
                                    return Material(
                                      child: ListTile(
                                        textColor: cTitleColor,
                                        tileColor: cCardMainColor,
                                        leading: Text(
                                          kNews[index].date.formatDateTime(),
                                          style: TextStyle(
                                            fontSize: textSize,
                                          ),
                                        ),
                                        title: Text(
                                          kNews[index].news,
                                          style: TextStyle(
                                            fontSize: textSize,
                                          ),
                                        ),
                                        // color: Colors.black12,
                                        // child: Padding(
                                        //   padding: const EdgeInsets.all(5),
                                        //   child: Row(
                                        //     children: [
                                        //       Text(
                                        //         '${kNews[index].date.formatDateTime()}: ',
                                        //         style: TextStyle(
                                        //           color: Colors.white,
                                        //           fontSize: textSize,
                                        //         ),
                                        //       ),
                                        //       Text(
                                        //         kNews[index].news,
                                        //         style: TextStyle(
                                        //           color: Colors.white,
                                        //           fontSize: textSize,
                                        //         ),
                                        //       ),
                                        //     ],
                                        //   ),
                                        // ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: ZoomTapAnimation(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Icon(
                              Icons.close,
                              color: Colors.red,
                              size: iconSize,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          },
          child: MouseRegion(
            onEnter: (event) => onEntered(true),
            onExit: (event) => onEntered(false),
            child: Transform.scale(
              scale: isHovered ? 1.2 : 1.0,
              child: Stack(
                children: [
                  Icon(
                    Icons.newspaper,
                    size: iconSize,
                    color: cIconAltColor,
                  ),
                  // Positioned(
                  //   right: 0,
                  //   top: 5,
                  //   child: Container(
                  //     decoration: new BoxDecoration(
                  //       color: Colors.red,
                  //       borderRadius: BorderRadius.circular(7),
                  //     ),
                  //     constraints: const BoxConstraints(
                  //       minWidth: 10,
                  //       minHeight: 10,
                  //     ),
                  //     child: const SizedBox(
                  //       width: 1,
                  //       height: 1,
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
