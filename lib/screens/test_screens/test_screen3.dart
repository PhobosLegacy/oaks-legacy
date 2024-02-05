// import 'package:flutter/material.dart';
// import 'package:oaks_legacy/components/app_bar.dart';

// //GRID VIEW WITH EXPANDED
// class TestListScreen3 extends StatefulWidget {
//   const TestListScreen3({
//     super.key,
//   });

//   @override
//   State<TestListScreen3> createState() => _TestListScreen3State();
// }

// class _TestListScreen3State extends State<TestListScreen3> {
//   @override
//   void initState() {
//     super.initState();
//   }

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
//           SafeArea(
//             child: Column(
//               children: [
//                 Expanded(
//                   child: GridView.count(
//                     crossAxisSpacing: 5,
//                     mainAxisSpacing: 5,
//                     crossAxisCount: 6,
//                     childAspectRatio: 2,
//                     shrinkWrap: true,
//                     padding: const EdgeInsets.all(5),
//                     scrollDirection: Axis.vertical,
//                     children: List.generate(200, (index) {
//                       return OverflowBox(
//                         maxHeight: 1000,
//                         alignment: Alignment.topCenter,
//                         child: Card(
//                           clipBehavior: Clip.antiAlias,
//                           child: ExpansionTile(
//                             trailing: SizedBox(),
//                             title: FittedBox(
//                               fit: BoxFit.scaleDown,
//                               child: Row(
//                                 children: [
//                                   Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       FittedBox(
//                                         fit: BoxFit.scaleDown,
//                                         child: Center(
//                                           child: Text(
//                                             "${index} THIS IS THE NAME",
//                                             style: TextStyle(
//                                                 fontWeight: FontWeight.bold,
//                                                 color: Colors.white,
//                                                 fontSize: 50),
//                                           ),
//                                         ),
//                                       ),
//                                       FittedBox(
//                                         fit: BoxFit.scaleDown,
//                                         child: Text(
//                                           "THIS IS THE OTHER NAME",
//                                           style: TextStyle(
//                                               fontSize: 25,
//                                               fontWeight: FontWeight.bold,
//                                               color: Colors.white),
//                                         ),
//                                       ),
//                                       Row(
//                                         children: [
//                                           SizedBox(
//                                             height: 50,
//                                           ),
//                                           SizedBox(
//                                             height: 50,
//                                           ),
//                                         ],
//                                       )
//                                     ],
//                                   )
//                                 ],
//                               ),
//                             ),
//                             backgroundColor: Colors.lightGreen,
//                             collapsedBackgroundColor: Colors.black26,
//                             children: const [
//                               Text('This is tile '),
//                               ListTile(title: Text('This is tile ')),
//                               ListTile(title: Text('This is tile ')),
//                               ListTile(title: Text('This is tile ')),
//                               ListTile(title: Text('This is tile ')),
//                               ListTile(title: Text('This is tile ')),
//                               ListTile(title: Text('This is tile ')),
//                               ListTile(title: Text('This is tile ')),
//                             ],
//                           ),
//                         ),
//                       );
//                     }),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
