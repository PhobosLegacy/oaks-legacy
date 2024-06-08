import 'package:flutter/material.dart';

class SwitchOption extends StatelessWidget {
  const SwitchOption({
    required this.title,
    required this.switchValue,
    required this.onSwitch,
    super.key,
  });

  final String title;
  final bool switchValue;
  final Function(bool) onSwitch;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.black26, //(color != null) ? color : Colors.white,
      shadowColor: Colors.black26,
      borderOnForeground: true,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: const TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
          Switch(
            value: switchValue,
            activeColor: Colors.green,
            onChanged: (bool value) => {onSwitch(value)},
          )
        ],
      ),
    );
  }
}
