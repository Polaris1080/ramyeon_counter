// Base
import '../base/ramyeon_image_base.dart';
import '../base/ramyeon_image_base_vm.dart';
// Package
import 'package:flutter/material.dart';
// Partical
part 'ramyeon_image_viewer_detail.dart';
part 'ramyeon_image_viewer_vm.dart';

class RamyeonImageViewer extends RamyeonImageBase {
  const RamyeonImageViewer({super.key, required this.vm}) : super(vm);

  final RamyeonImageViewerViewModel vm;

  @override
  Widget overlayArea(BuildContext context) {
    return Center(
      // Visibility(Hovering)
      child: ListenableBuilder(
        listenable: vm,
        builder: (_, c) => Visibility(visible: vm.isHovering, child: c!),
        // Path
        child: ListenableBuilder(
          listenable: vm,
          builder: (_, d) => vm.isImagePathExist
              ? d!
              : circularIcon(Icons.image_not_supported_outlined),
          // Loading
          child: ListenableBuilder(
            listenable: vm,
            builder: (_, e) => vm.isImageLoaded
                ? e!
                : circularIcon(Icons.broken_image_outlined),
            child: actionIcon(
              Icons.zoom_in_outlined,
              onPressed: () => vm.onDetailButtonPressed(context),
            ),
          ),
        ),
      ),
    );
  }
}
