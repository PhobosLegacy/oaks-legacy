// import 'package:flutter/material.dart';
// import 'package:oaks_legacy/components/app_bar.dart';
// import 'package:oaks_legacy/components/base_background.dart';
// import 'package:oaks_legacy/screens/test_screens/test_screen.dart';
// import 'package:oaks_legacy/screens/test_screens/test_screen2.dart';
// import 'package:oaks_legacy/screens/test_screens/test_screen3.dart';
// import 'package:oaks_legacy/screens/test_screens/test_screen4.dart';
// import 'package:oaks_legacy/screens/test_screens/test_screen5.dart';
// import 'package:oaks_legacy/screens/test_screens/test_screen6.dart';

// class MainTestScreen extends StatefulWidget {
//   const MainTestScreen({
//     super.key,
//   });

//   @override
//   State<MainTestScreen> createState() => _MainTestScreenState();
// }

// class _MainTestScreenState extends State<MainTestScreen> {
//   final List<Map<String, dynamic>> screenButtons = [
//     {"screen": const TestListScreen(), "text": "GO 1"},
//     {"screen": const TestListScreen2(), "text": "GO 2"},
//     {"screen": const TestListScreen3(), "text": "GO 3"},
//     {"screen": const TestListScreen4(), "text": "GO 4"},
//     {"screen": const TestListScreen5(), "text": "GO 5"},
//     {"screen": const TestListScreen6(), "text": "GO 6"},
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       appBar: AppBarBase(
//         title: const Text(
//           "Test",
//           style: TextStyle(
//             color: Colors.white,
//           ),
//         ),
//         actions: null,
//         color: Colors.blueGrey[800],
//       ),
//       body: Stack(
//         children: [
//           const BaseBackground(),
//           SafeArea(
//             child: Row(
//               children: _buildScreenButtons(),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   List<Widget> _buildScreenButtons() {
//     return screenButtons.map((buttonInfo) {
//       return Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Container(
//           width: 100,
//           height: 100,
//           color: Colors.white,
//           child: TextButton(
//             onPressed: () {
//               openNextScreen(buttonInfo["screen"]);
//             },
//             child: Text(buttonInfo["text"]),
//           ),
//         ),
//       );
//     }).toList();
//   }

//   void openNextScreen(screen) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) {
//           return screen;
//         },
//       ),
//     );
//   }
// }
