import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ramyeon_counter/model/ramyeon.dart';
import 'package:ramyeon_counter/model/ramyeon_list_data.dart';

import 'ramyeon_image_base.dart';
import 'ramyeon_image_viewer_vm.dart';

class RamyeonImageViewer extends RamyeonImageBase {
  RamyeonImageViewer({
    super.key,
    required Color? packageColor,
    required int ramyeonId,
  }) : super(RamyeonImageViewerViewModel(), packageColor, ramyeonId);

  @override
  Widget build(BuildContext context) {
    final vm = this.vm as RamyeonImageViewerViewModel;
    final circularClipRadius = BorderRadius.circular(10);
    final emptyBorderColor = packageColor != null
        ? ColorScheme.fromSeed(seedColor: packageColor!).tertiaryContainer
        : ColorScheme.of(context).tertiaryContainer;

    return AspectRatio(
      aspectRatio: 1,
      child: Stack(
        children: [
          ListenableBuilder(
            listenable: vm,
            builder: (_, _) {
              /* Image（登録済）*/
              if (vm.imagePath != null) {
                return GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ImageViewerDetail(vm.imagePath!),
                    ),
                  ),
                  child: Hero(
                    tag: ImageViewerDetail.heroTag,
                    child: Image.file(.new(vm.imagePath!)),
                  ),
                );
              }
              /* emptyBorder（未登録）*/
              else {
                return Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: emptyBorderColor, width: 2.0),
                    borderRadius: circularClipRadius,
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

class ImageViewerDetail extends StatelessWidget {
  const ImageViewerDetail(this.imagePath, {super.key});

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Hero(
              tag: ImageViewerDetail.heroTag,
              child: Container(
                constraints: BoxConstraints(maxWidth: 1024, maxHeight: 1024),
                child: Image.file(.new(imagePath)),
              ),
            ),
          ),
        ),
      ),
    );
  }

  static const heroTag = 'imageHero';
}
