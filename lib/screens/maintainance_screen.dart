import 'package:flutter/material.dart';
import 'package:oaks_legacy/components/base_background.dart';

class MaintainanceScreen extends StatefulWidget {
  const MaintainanceScreen({super.key});

  @override
  State<MaintainanceScreen> createState() => _MaintainanceScreenState();
}

class _MaintainanceScreenState extends State<MaintainanceScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Stack(
        children: [
          BaseBackground(),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "We will be right back",
                  style: TextStyle(
                    fontSize: 60,
                    color: Colors.amber,
                  ),
                ),
                Text(
                  "(Or not...)",
                  style: TextStyle(
                    fontSize: 40,
                    color: Colors.amber,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
