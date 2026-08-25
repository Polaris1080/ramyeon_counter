part of 'ramyeon_image_register.dart';

class RamyeonImageRegisterViewModel({required super.brandId})
    extends RamyeonImageBaseViewModel {
  /// Captured image path.
  @OneWay()
  String? get temporaryImagePath => _temporaryImagePath;
  String? _temporaryImagePath;
  @protected
  set temporaryImagePath(String value) {
    if (_temporaryImagePath != value) {
      _temporaryImagePath = value;
      super.imagePath = value;
    }
  }

  /* Command */
  Future onCaptureButtonPressed() async {
    // Capture image.
    final XFile? image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (image == null) return;
    // Captured image remains?
    if (temporaryImagePath != null) {
      final file = File(temporaryImagePath!);
      if (await file.exists()) {
        await file.delete();
      }
    }
    // Save image.
    final String path =
        '${(await getTemporaryDirectory()).path}/${basename(image.path)}';
    image.saveTo(path);
    temporaryImagePath = path;
  }

  /* Function */
  Future saveImage() async {
    if (temporaryImagePath == null) return;
    // Serialize image.
    final file = File(temporaryImagePath!);
    if (await file.exists()) {
      await file.copy(thumbnailPath);
    }
  }
}
