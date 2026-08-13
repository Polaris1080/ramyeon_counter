// Base
import './ramyeon_image_viewer_vm.dart';

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
    required this.vm,
    super.packageColor,
  }) : super(viewmodel: vm);

  final RamyeonImageViewerViewModel vm;

  @override
  Widget overlayArea(BuildContext context) {
    return Center(
      // Visibility(Hovering)
      child: ListenableBuilder(
        listenable: vm,
        builder: (_, c) => Visibility(visible: vm.isHovering, child: c!),
        // Path...
        child: ListenableBuilder(
          listenable: vm,
          builder: (_, _) => switch (vm.imagePath) {
            // ...may exist(Loading...)
            _? => ListenableBuilder(
              listenable: vm,
              builder: (_, _) => vm.isImageLoaded
                  // ...success
                  ? actionIcon(
                      Icons.zoom_in_outlined,
                      onPressed: () => onOverlayButtonPressed(context),
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

  void onOverlayButtonPressed(BuildContext context) => Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => RamyeonImageViewerDetail(Image.file(.new(vm.imagePath!))),
    ),
  );
}
