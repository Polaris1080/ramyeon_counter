

import 'base/ramyeon_image_base.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class RamyeonImageRegister extends RamyeonImageBase {
  RamyeonImageRegister(
    super.ramyeon,
    super.ramyeonId,
    super.context, {
    super.key,
    required super.imagePath,
  });

  @override
  Widget get imageArea => ValueListenableBuilder(
    valueListenable: imagePath,
    builder: (context, path, _) => switch (path) {
      _? => imageViewer(imagePath: path),
      _ => emptyBorder,
    },
  );

  @override
  Widget get overlayArea => Center(
    child: ValueListenableBuilder(
      valueListenable: isHovering,
      builder: (_, f, w) => Visibility(visible: f, child: w!),
      /* Add-Image Button */
      child: IconButton.filled(
        style: IconButton.styleFrom(
          backgroundColor: Colors.blue, // 背景色
          foregroundColor: Colors.white, // アイコンの色
        ),
        onPressed: () async {
          final picker = ImagePicker();
          // Pick an image.
          final XFile? image = await picker.pickImage(
            source: ImageSource.gallery,
          );
          if (image == null) return;

          // Step 3: Get directory where we can duplicate selected file.
          final String duplicateFilePath = (await getTemporaryDirectory()).path;

          // Step 4: Copy the file to a application document directory.
          final fileName = basename(image.path);
          await image.saveTo('$duplicateFilePath/$fileName');
          imagePath.value = '$duplicateFilePath/$fileName';
        },
        icon: Icon(Icons.add_photo_alternate_outlined),
      ),
    ),
  );

  // @override
  // Widget build(BuildContext context) {
  //   return baseWidget(
  //     view: ValueListenableBuilder(
  //           valueListenable: imagePath,
  //           builder: (_, path, _) => switch (path) {
  //             _? => imageViewer(imagePath: path),
  //             _ => emptyBorder,
  //           },
  //         ),
  //     over: Center(
  //           child: ValueListenableBuilder(
  //             valueListenable: isHovering,
  //             builder: (_, f, w) => Visibility(visible: f, child: w!),
  //             /* Add-Image Button */
  //             child: IconButton.filled(
  //               style: IconButton.styleFrom(
  //                 backgroundColor: Colors.blue, // 背景色
  //                 foregroundColor: Colors.white, // アイコンの色
  //               ),
  //               onPressed: () async {
  //                 final picker = ImagePicker();
  //                 // Pick an image.
  //                 final XFile? image = await picker.pickImage(
  //                   source: ImageSource.gallery,
  //                 );
  //                 if (image == null) return;

  //                 // Step 3: Get directory where we can duplicate selected file.
  //                 final String duplicateFilePath =
  //                     (await getTemporaryDirectory()).path;

  //                 // Step 4: Copy the file to a application document directory.
  //                 final fileName = basename(image.path);
  //                 await image.saveTo('$duplicateFilePath/$fileName');
  //                 imagePath.value = '$duplicateFilePath/$fileName';
  //               },
  //               icon: Icon(Icons.add_photo_alternate_outlined),
  //             ),
  //           ),
  //         ),
  //   );
  //}
}
