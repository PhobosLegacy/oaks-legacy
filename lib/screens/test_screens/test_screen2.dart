import 'package:flutter/material.dart';

//Container ANIMATED
class TestListScreen2 extends StatefulWidget {
  const TestListScreen2({
    super.key,
  });

  @override
  State<TestListScreen2> createState() => _TestListScreen2State();
}

class _TestListScreen2State extends State<TestListScreen2> {
  @override
  void initState() {
    super.initState();
  }

  //number of childs used in the example
  static const itemCount = 300;

//list of each bloc expandable state, that is changed to trigger the animation of the AnimatedContainer
  List<bool> expandableState = List.generate(itemCount, (index) => false);

  Widget bloc(double width, int index) {
    bool isExpanded = expandableState[index];

    return GestureDetector(
      onTap: () {
        setState(() {
          //changing the current expandableState
          expandableState[index] = !isExpanded;
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        margin: const EdgeInsets.all(20.0),
        width: width * 0.2,
        height: !isExpanded ? width * 0.2 : width * 0.4,
        color: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Align(
        child: SingleChildScrollView(
          child: Wrap(
            children: List.generate(itemCount, (index) {
              return bloc(width, index);
            }),
          ),
        ),
      ),
    );
  }
}

// class _TestListScreen2State extends State<TestListScreen2> {
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
