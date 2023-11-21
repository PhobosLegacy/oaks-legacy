import 'package:flutter/material.dart';

class DetailsAppBar extends StatelessWidget {
  const DetailsAppBar({
    super.key,
    required this.name,
    this.number = "",
  });

  final String name;
  final String number;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      title: Column(
        children: [
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              name,
              style: const TextStyle(
                fontSize: 45,
                fontFamily: 'SigmarOne',
                color: Colors.black,
              ),
            ),
          ),
          // const Divider(
          //   thickness: 2,
          //   color: Colors.black,
          //   height: 0.5,
          // ),
          // if (number != "" && number.isNotEmpty)
          //   Text(
          //     '#$number',
          //     style: const TextStyle(
          //       fontFamily: 'SigmarOne',
          //       color: Colors.black,
          //     ),
          //   ),
        ],
      ),
    );
  }
}


// title: Row(
//         children: [
//           Expanded(
//             flex: 4,
//             child: FittedBox(
//               fit: BoxFit.scaleDown,
//               child: Text(
//                 name,
//                 style: const TextStyle(
//                   fontSize: 25,
//                   fontFamily: 'SigmarOne',
//                   color: Colors.black,
//                 ),
//               ),
//             ),
//           ),
//           const Spacer(),
//           if (number != "" && number.isNotEmpty)
//             Expanded(
//               child: FittedBox(
//                 fit: BoxFit.scaleDown,
//                 child: Text(
//                   '#$number',
//                   style: const TextStyle(
//                     fontFamily: 'SigmarOne',
//                     color: Colors.black,
//                   ),
//                 ),
//               ),
//             ),
//         ],
//       ),