import 'package:flutter/material.dart';

class TextDivider extends StatelessWidget {
  const TextDivider(
      {super.key,
      required this.text,
      this.fontSize = 15,
      this.dividerHeight = 25});

  final String text;
  final double fontSize;
  final double dividerHeight;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
              margin: const EdgeInsets.only(left: 10.0, right: 5.0),
              child: Divider(
                color: Colors.yellow,
                height: dividerHeight,
              )),
        ),
        Text(
          text,
          style: TextStyle(
            fontSize: fontSize,
            color: Colors.white,
          ),
        ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(left: 5.0, right: 10.0),
            child: Divider(
              color: Colors.yellow,
              height: dividerHeight,
            ),
          ),
        ),
      ],
    );
  }
}

class SubTextDivider extends StatelessWidget {
  const SubTextDivider({super.key, required this.text});

  final String text;
  @override
  Widget build(BuildContext context) {
    return TextDivider(
      text: text,
      fontSize: 12.5,
      dividerHeight: 15,
    );
  }
}

class DetailsCard extends StatelessWidget {
  const DetailsCard(
      {super.key,
      required this.cardChild,
      required this.blockTitle,
      this.flex = 1});

  final String blockTitle;
  final Widget cardChild;
  final int flex;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Container(
        margin: const EdgeInsets.all(6.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.black12,
        ),
        child: Column(
          children: [
            TextDivider(text: blockTitle),
            cardChild,
          ],
        ),
      ),
    );
  }
}
