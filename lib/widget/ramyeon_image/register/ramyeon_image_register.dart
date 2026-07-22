// Base
import '../base/ramyeon_image_base.dart';
// Package
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class RamyeonImageRegister extends RamyeonImageBase {
  // TODO【後で見直す】
  RamyeonImageRegister(
    super.context,
    super.ramyeonId, {
    super.key,
    super.imgPath,
    super.packageColor,
  });

  @override
  // TODO【後で見直す】
  Widget overlayArea(BuildContext context) {
    Future onLoadButtonPressed() async {
      final picker = ImagePicker();
      // Pick an image.
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image == null) return;

      // Step 3: Get directory where we can duplicate selected file.
      final String duplicateFilePath = (await getTemporaryDirectory()).path;

      // Step 4: Copy the file to a application document directory.
      final fileName = basename(image.path);
      await image.saveTo('$duplicateFilePath/$fileName');
      imagePath.value = '$duplicateFilePath/$fileName';
    }

    return Center(
      // Visibility(Hovering)
      child: ValueListenableBuilder(
        valueListenable: isHovering,
        builder: (_, hovering, w) => Visibility(visible: hovering, child: w!),
        child: actionIcon(
          Icons.add_photo_alternate_outlined,
          onPressed: onLoadButtonPressed,
        ),
      ),
    );
  }
}
