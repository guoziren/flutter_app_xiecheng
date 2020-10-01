


import 'package:flutter/material.dart';

class CachedImage extends StatelessWidget {
  final AlignmentGeometry alignmentGeometry;
  final BoxFit fit;
  final String imageUrl;
  final double width;
  final double height;
  final bool isSizedBox;

  const CachedImage({Key key, this.alignmentGeometry, this.fit, this.imageUrl, this.width, this.height, this.isSizedBox}) : super(key: key);




  @override
  Widget build(BuildContext context) {
    return isSizedBox
        ? FractionallySizedBox(): null;

  }
}
