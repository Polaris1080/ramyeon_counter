// Base
import '../base/ramyeon_image_base.dart';
// Package
import 'package:flutter/material.dart';
// Partical
part 'ramyeon_image_viewer_detail.dart';

class RamyeonImageViewer extends RamyeonImageBase {
  // TODO【後で見直す】
  RamyeonImageViewer(
    super.context,
    super.ramyeonId, {
    super.key,
    super.packageColor,
  });

  @override
  Widget overlayArea(BuildContext context) {
    void onZoomButtonPressed() => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) =>
            RamyeonImageViewerDetail(Image.file(.new(imagePath.value!))),
      ),
    );

    return Center(
      // Visibility(Hovering)
      child: ValueListenableBuilder(
        valueListenable: isHovering,
        builder: (_, hovering, w) => Visibility(visible: hovering, child: w!),
        // Path...
        child: ValueListenableBuilder(
          valueListenable: imagePath,
          builder: (_, path, _) => switch (path) {
            // ...may exist(Loading...)
            _? => ValueListenableBuilder(
              valueListenable: isImageLoaded,
              builder: (_, loaded, _) => loaded
                  // ...success
                  ? actionIcon(
                      Icons.zoom_in_outlined,
                      onPressed: onZoomButtonPressed,
                    )
                  // ...error
                  : Icon(Icons.broken_image_outlined),
            ),
            // ...not exist
            null => circularIcon(Icons.image_not_supported_outlined),
          },
        ),
      ),
    );
  }
}
