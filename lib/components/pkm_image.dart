// import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:oaks_legacy/components/image.dart';
import 'package:oaks_legacy/constants.dart';

class PkmImage extends StatelessWidget {
  final String image;
  final Object heroTag;
  final bool? shadowOnly;
  final double height;

  const PkmImage({
    super.key,
    required this.image,
    required this.heroTag,
    this.shadowOnly,
    this.height = 600,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Hero(
        tag: heroTag,
        child: SizedBox(
          child: Stack(
            children: (shadowOnly == true)
                ? [
                    getImage('$kImageLocalPrefix$image', height, shadow: true),
                  ]
                : [
                    getImage('$kImageLocalPrefix$image', height, shadow: true),
                    getImage('$kImageLocalPrefix$image', height - 5),
                  ],
            // children: (shadowOnly == true)
            //     ? [
            //         CachedNetworkImage(
            //           imageUrl: "$kImageLocalPrefix/$image",
            //           color: Colors.black87,
            //           height: height,
            //           placeholder: (context, url) => const Center(
            //             child: CircularProgressIndicator(
            //               color: Colors.red,
            //             ),
            //           ),
            //         ),
            //       ]
            //     : [
            //         // CachedNetworkImage(
            //         //   imageUrl: "$kImageLocalPrefix/$image",
            //         //   color: Colors.black87,
            //         //   height: height,
            //         //   placeholder: (context, url) => const Center(
            //         //     child: CircularProgressIndicator(
            //         //       color: Colors.red,
            //         //     ),
            //         //   ),
            //         // ),
            //         CachedNetworkImage(
            //           imageUrl: "$kImageLocalPrefix/$image",
            //           height: height,
            //           placeholder: (context, url) => const Center(
            //             child: CircularProgressIndicator(
            //               color: Colors.red,
            //             ),
            //           ),
            //         ),
            //       ],
          ),
        ),
      ),
    );
    // return FutureBuilder<ImageProvider>(
    //   future: _getImage(context, "$kImageLocalPrefix/$image"),
    //   builder: (context, AsyncSnapshot<ImageProvider> snapshot) {
    //     if (snapshot.connectionState == ConnectionState.waiting) {
    //       return const Center(
    //         child: CircularProgressIndicator(
    //           color: Colors.red,
    //         ),
    //       );
    //     } else if (snapshot.hasError) {
    //       return const Center(
    //         child: Text('Failed to load image'),
    //       );
    //     } else {
    //       return Hero(
    //         tag: heroTag,
    //         child: SizedBox(
    //           child: Stack(
    //             children: (shadowOnly == true)
    //                 ? [
    //                     Image.network(
    //                       "$kImageLocalPrefix/$image",
    //                       color: Colors.black87,
    //                       height: height,
    //                     ),
    //                   ]
    //                 : [
    //                     Image.network(
    //                       "$kImageLocalPrefix/$image",
    //                       color: Colors.black87,
    //                       height: height,
    //                     ),
    //                     Image.network(
    //                       "$kImageLocalPrefix/$image",
    //                       height: height - 5,
    //                     ),
    //                   ],
    //           ),
    //         ),
    //       );
    //     }
    //   },
    // );
  }

  // Future<ImageProvider> _getImage(BuildContext context, String imageUrl) async {
  //   final Completer<ImageProvider> completer = Completer<ImageProvider>();

  //   final ImageStream stream =
  //       Image.network(imageUrl).image.resolve(ImageConfiguration.empty);
  //   stream.addListener(
  //     ImageStreamListener((ImageInfo image, bool synchronousCall) {
  //       completer.complete(NetworkImage(imageUrl));
  //     }),
  //   );

  //   return completer.future;
  // }
}
