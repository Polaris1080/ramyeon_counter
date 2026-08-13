// Base
import 'ramyeon_image_base_vm.dart';
// Package
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

abstract class RamyeonImageBase extends StatelessWidget {
  /* Setting */
  static const heroTag = 'imageHero',
      _circularBackgroundColor = Colors.blue,
      _circularClipRadius = 10.0,
      _circularIconColor = Colors.white,
      _hoverOpacity = 0.8;

  // TODO【後で見直す】
  const RamyeonImageBase(RamyeonImageBaseViewModel vm, {super.key}) : _vm = vm;

  final RamyeonImageBaseViewModel _vm;

  /* Build */
  @override
  Widget build(BuildContext context) {
    /* Widget */
    Widget emptyBorder = Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: ColorScheme.of(context).tertiaryContainer,
          width: 2.0,
        ),
        borderRadius: const .all(.circular(_circularClipRadius)),
      ),
    );

    // アスペクト調整 & マウス検知
    return AspectRatio(
      aspectRatio: 1,
      child: MouseRegion(
        onEnter: _vm.hoverRegionEnter,
        onExit: _vm.hoverRegionExit,
        opaque: false,
        child: Stack(
          children: [
            // Path...
            ListenableBuilder(
              listenable: _vm,
              builder: (context, _) => switch (_vm.imagePath) {
                // ...may exist(Opacity)
                _? => ListenableBuilder(
                  listenable: _vm,
                  builder: (_, w) {
                    return Opacity(
                      opacity: _vm.isHovering ? _hoverOpacity : 1.0,
                      child: w!,
                    );
                  },
                  child: Hero(
                    tag: heroTag,
                    // Loading(...success)
                    child: Image.file(
                      .new(_vm.imagePath!),
                      fit: BoxFit.cover,
                      // ...error
                      errorBuilder: (context, error, stackTrace) {
                        return emptyBorder;
                      },
                    ),
                  ),
                ),
                _ => emptyBorder,
              },
            ),
            overlayArea(context),
          ],
        ),
      ),
    );
  }

  /* Widget */
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
