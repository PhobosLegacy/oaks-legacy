import 'package:flutter/material.dart';

class PkmEditableButton extends StatelessWidget {
  const PkmEditableButton({
    super.key,
    required this.title,
    required this.content,
    required this.isEnabled,
    this.onTap,
  });

  final String title;
  final Widget content;
  final bool isEnabled;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    bool isSmallScreen = MediaQuery.of(context).size.width < 400;

    return Expanded(
      child: GestureDetector(
        onTap: isEnabled ? onTap : null,
        child: Card(
          shape: (isEnabled)
              ? RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: const BorderSide(color: Colors.yellow),
                )
              : null,
          color: Colors.black12,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: (isSmallScreen) ? 50 : 100,
                width: 200,
                child: Center(child: content),
              ),
              Text(
                title,
                style: TextStyle(
                  color: Colors.amber,
                  fontSize: (isSmallScreen) ? 10 : 15,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
