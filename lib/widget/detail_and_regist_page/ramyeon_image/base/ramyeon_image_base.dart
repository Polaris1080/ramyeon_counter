// Base
import 'ramyeon_image_base_vm.dart';

// Package
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

abstract class const RamyeonImageBase(RamyeonImageBaseViewModel vm, {super.key})
    extends StatelessWidget {
  /* Setting */
  static const heroTag = 'imageHero',
      _circularBackgroundColor = Colors.blue,
      _circularIconColor = Colors.white,
      _circularClipRadius = 10.0;

  final RamyeonImageBaseViewModel _vm = vm;

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
              builder: (context, _) => _vm.isImagePathExist
                  ? ListenableBuilder(
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
                              _vm.imageLoadingErrorOccurred();
                            });
                            return _emptyBorder(context);
                          },
                        ),
                      ),
                    )
                  : _emptyBorder(context),
              // TODO:暫定対策
              // Visibility(Hovering)
              // child: ListenableBuilder(
              //   listenable: _vm,
              //   builder: (_, d) =>
              //       Opacity(opacity: _vm.hoveringOpacity, child: d!),
              //   child: Hero(
              //     tag: heroTag,
              //     // Loading(...success)
              //     child: Image.file(
              //       .new(_vm.imagePath!),
              //       fit: BoxFit.cover,
              //       // ...error
              //       errorBuilder: (context, error, stackTrace) {
              //         WidgetsBinding.instance.addPostFrameCallback((_) {
              //           _vm.imageLoadingErrorOccurred();
              //         });
              //         return _emptyBorder(context);
              //       },
              //     ),
              //   ),
              //),
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
