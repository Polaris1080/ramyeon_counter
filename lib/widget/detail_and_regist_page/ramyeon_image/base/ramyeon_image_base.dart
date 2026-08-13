// Base
import 'ramyeon_image_base_vm.dart';
// Package
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

abstract class RamyeonImageBase extends StatelessWidget {
  /* Setting */
  static const heroTag = 'imageHero',
      _circularBackgroundColor = Colors.blue,
      _circularIconColor = Colors.white,
      _circularClipRadius = 10.0;

  const RamyeonImageBase(RamyeonImageBaseViewModel vm, {super.key}) : _vm = vm;

  final RamyeonImageBaseViewModel _vm;

  @override
  Widget build(BuildContext context) {
    // Tune aspect & Detect mouse.
    return AspectRatio(
      aspectRatio: 1,
      child: MouseRegion(
        onEnter: _vm.hoverRegionEnter,
        onExit: _vm.hoverRegionExit,
        opaque: false,
        child: Stack(
          children: [
            // Path
            ListenableBuilder(
              listenable: _vm,
              builder: (context, c) =>
                  _vm.isImagePathExist ? c! : _emptyBorder(context),
              // Visibility(Hovering)
              child: ListenableBuilder(
                listenable: _vm,
                builder: (_, d) =>
                    Opacity(opacity: _vm.hoveringOpacity, child: d!),
                child: Hero(
                  tag: heroTag,
                  // Loading(...success)
                  child: Image.file(
                    .new(_vm.imagePath!),
                    fit: BoxFit.cover,
                    // ...error
                    errorBuilder: (context, error, stackTrace) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        _vm.isImageLoaded = false;
                      });
                      return _emptyBorder(context);
                    },
                  ),
                ),
              ),
            ),
            overlayArea(context),
          ],
        ),
      ),
    );
  }

  /* Widget */
  Widget _emptyBorder(BuildContext context) => Container(
    decoration: BoxDecoration(
      border: Border.all(
        color: ColorScheme.of(context).tertiaryContainer,
        width: 2.0,
      ),
      borderRadius: const .all(.circular(_circularClipRadius)),
    ),
  );

  @protected
  Widget actionIcon(IconData icon, {VoidCallback? onPressed}) =>
      IconButton.filled(
        style: IconButton.styleFrom(
          backgroundColor: _circularBackgroundColor,
          foregroundColor: _circularIconColor,
        ),
        onPressed: onPressed,
        icon: Icon(icon),
      );

  @protected
  Widget circularIcon(IconData icon) => CircleAvatar(
    radius: 20,
    backgroundColor: _circularBackgroundColor,
    child: Icon(icon, color: _circularIconColor),
  );

  @protected
  @mustBeOverridden
  Widget overlayArea(BuildContext context);
}
