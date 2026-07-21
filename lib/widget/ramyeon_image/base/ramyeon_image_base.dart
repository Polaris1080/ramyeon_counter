import 'dart:io';

import 'package:flutter/material.dart';

abstract class RamyeonImageBase extends StatelessWidget {
  static const _circularClipRadius = 10.0, _emptyBorderRadius = 10.0;

  RamyeonImageBase(
    this.packageColor,
    int? ramyeonId,
    BuildContext context, {
    super.key,
    required this.imagePath,
  }) : _emptyBorderColor = switch (packageColor) {
         _? => ColorScheme.fromSeed(seedColor: packageColor),
         _ => ColorScheme.of(context),
       }.tertiaryContainer {
    if (ramyeonId != null) {
      if (File('C:/Users/Polar/Documents/${ramyeonId}_full.JPG').existsSync()) {
        imagePath.value = 'C:/Users/Polar/Documents/${ramyeonId}_full.JPG';
      }
    }
  }


  /* Argument */
  final ValueNotifier<String?> imagePath;
  final Color? packageColor;

  /* Value */
  final Color _emptyBorderColor;
  final ValueNotifier<bool> isHovering = .new(false);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: MouseRegion(
        onEnter: (_) => isHovering.value = true,
        onExit: (_) => isHovering.value = false,
        opaque: false,
        child: Stack(children: [imageArea, overlayArea]),
      ),
    );
  }

  /* Widget */
  Widget get imageArea;
  Widget get overlayArea;

  Widget imageViewer({required String imagePath}) => ValueListenableBuilder(
    valueListenable: isHovering,
    builder: (context, value, child) {
      return Opacity(opacity: value ? 0.8 : 1.0, child: child!);
    },
    child: ClipRRect(
      borderRadius: BorderRadius.circular(_circularClipRadius),
      child: Image.file(
        .new(imagePath),
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => emptyBorder,
      ),
    ),
  );

  Widget get emptyBorder => Container(
    decoration: BoxDecoration(
      border: Border.all(color: _emptyBorderColor, width: 2.0),
      borderRadius: const .all(.circular(_emptyBorderRadius)),
    ),
  );
}
