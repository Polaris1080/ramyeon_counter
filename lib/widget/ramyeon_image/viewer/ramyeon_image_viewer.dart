// Base
import '../base/ramyeon_image_base.dart';
// Package
import 'package:flutter/material.dart';
// Partical
part 'ramyeon_image_viewer_detail.dart';

class RamyeonImageViewer extends RamyeonImageBase {
  /* Setting */
  static const heroTag = 'imageHero';

  RamyeonImageViewer({
    super.key,
    required Color? packageColor,
    required int ramyeonId,
    required BuildContext context,
  }) : super(
         packageColor,
         ramyeonId,
         context,
         imagePath: .new(null),
       );

  @override
  Widget get imageArea => ValueListenableBuilder(
    valueListenable: imagePath,
    builder: (context, path, _) => switch (path) {
      _? => GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                RamyeonImageViewerDetail(Image.file(.new(path))),
          ),
        ),
        child: Hero(
          tag: RamyeonImageViewer.heroTag,
          child: imageViewer(imagePath: path),
        ),
      ),
      _ => emptyBorder,
    },
  );

  @override
  Widget get overlayArea => SizedBox();
}
