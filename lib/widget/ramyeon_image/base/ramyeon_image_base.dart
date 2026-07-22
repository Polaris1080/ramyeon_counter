// Package
import 'dart:io';
import 'package:flutter/material.dart';

abstract class RamyeonImageBase extends StatelessWidget {
  /* Setting */
  static const heroTag = 'imageHero',
      _circularBackgroundColor = Colors.blue,
      _circularClipRadius = 10.0,
      _circularIconColor = Colors.white,
      _hoverOpacity = 0.8;

  // TODO【後で見直す】
  RamyeonImageBase(
    BuildContext context,
    int? ramyeonId, {
    super.key,
    ValueNotifier<String?>? imgPath,
    Color? packageColor,
  }) : _emptyBorderColor = switch (packageColor) {
         _? => ColorScheme.fromSeed(seedColor: packageColor),
         _ => ColorScheme.of(context),
       }.tertiaryContainer,
       imagePath = switch (imgPath) {
         _? => imgPath,
         _ => .new(null),
       } {
    if (ramyeonId != null) {
      if (File('C:/Users/Polar/Documents/${ramyeonId}_full.JPG').existsSync()) {
        imagePath.value = 'C:/Users/Polar/Documents/${ramyeonId}_full.JPG';
      }
    }
  }

  /* Argument */
  final ValueNotifier<String?> imagePath;

  /* Value */
  final Color _emptyBorderColor;
  final ValueNotifier<bool> isHovering = .new(false);
  final ValueNotifier<bool> isImageLoaded = .new(false);

  /* Build */
  @override
  Widget build(BuildContext context) {
    /* Widget */
    Widget emptyBorder = Container(
      decoration: BoxDecoration(
        border: Border.all(color: _emptyBorderColor, width: 2.0),
        borderRadius: const .all(.circular(_circularClipRadius)),
      ),
    );

    // アスペクト調整 & マウス検知
    return AspectRatio(
      aspectRatio: 1,
      child: MouseRegion(
        onEnter: (_) => isHovering.value = true,
        onExit: (_) => isHovering.value = false,
        opaque: false,
        child: Stack(
          children: [
            // Path...
            ValueListenableBuilder(
              valueListenable: imagePath,
              builder: (context, path, _) => switch (path) {
                // ...may exist(Opacity)
                _? => ValueListenableBuilder(
                  valueListenable: isHovering,
                  builder: (_, h, w) {
                    isImageLoaded.value = true;
                    return Opacity(opacity: h ? _hoverOpacity : 1.0, child: w!);
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(_circularClipRadius),
                    child: Hero(
                      tag: heroTag,
                      // Loading(...success)
                      child: Image.file(
                        .new(path),
                        fit: BoxFit.cover,
                        // ...error
                        errorBuilder: (context, error, stackTrace) {
                          isImageLoaded.value = false;
                          return emptyBorder;
                        },
                      ),
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
  Widget circularIcon(IconData icon) => CircleAvatar(
    radius: 20,
    backgroundColor: _circularBackgroundColor,
    child: Icon(icon, color: _circularIconColor),
  );

  Widget actionIcon(IconData icon, {VoidCallback? onPressed}) =>
      IconButton.filled(
        style: IconButton.styleFrom(
          backgroundColor: _circularBackgroundColor,
          foregroundColor: _circularIconColor,
        ),
        onPressed: onPressed,
        icon: Icon(icon),
      );

  /* Overload */
  Widget overlayArea(BuildContext context);
}
