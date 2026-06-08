import 'dart:io';

import 'package:ramyeon_counter/model/ramyeon.dart';

import 'ramyeon_image_base.dart';
import 'ramyeon_image_register_vm.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class RamyeonImageRegister extends RamyeonImageBase {
  RamyeonImageRegister(
    RamyeonImageRegisterViewModel super.vm,
    super.ramyeon, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final vm = this.vm as RamyeonImageRegisterViewModel;
    final circularClipRadius = BorderRadius.circular(10);
    final emptyBorderColor = packageColor != null
        ? ColorScheme.fromSeed(seedColor: packageColor!).tertiaryContainer
        : ColorScheme.of(context).tertiaryContainer;

    return AspectRatio(
      aspectRatio: 1,
      child: MouseRegion(
        /* Hovering */
        onEnter: (_) => vm.isHovering = true,
        onExit: (_) => vm.isHovering = false,
        child: Stack(
          children: [
            ListenableBuilder(
              listenable: vm,
              builder: (_, _) {
                /* Image（登録済）*/
                if (vm.imagePath != null) {
                  return ListenableBuilder(
                    listenable: vm,
                    builder: (_, w) =>
                        Opacity(opacity: vm.imageOpacity, child: w!),
                    child: ClipRRect(
                      borderRadius: circularClipRadius,
                      child: Image.file(.new(vm.imagePath!), fit: BoxFit.cover),
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
            Center(
              child: ListenableBuilder(
                listenable: vm,
                builder: (_, w) =>
                    Visibility(visible: vm.isButtonVisible, child: w!),
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
                    final String duplicateFilePath =
                        (await getTemporaryDirectory()).path;

                    // Step 4: Copy the file to a application document directory.
                    final fileName = basename(image.path);
                    await image.saveTo('$duplicateFilePath/$fileName');
                    vm.imagePath = '$duplicateFilePath/$fileName';
                  },
                  icon: Icon(Icons.add_photo_alternate_outlined),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
