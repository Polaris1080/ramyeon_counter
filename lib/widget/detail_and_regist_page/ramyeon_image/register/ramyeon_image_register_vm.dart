part of 'ramyeon_image_register.dart';

class RamyeonImageRegisterViewModel extends RamyeonImageBaseViewModel {
  RamyeonImageRegisterViewModel({required int? brandId})
    : super(
        imagePath:
            brandId != null &&
                File(
                  'C:/Users/Polar/Documents/${brandId}_full.JPG',
                ).existsSync()
            ? 'C:/Users/Polar/Documents/${brandId}_full.JPG'
            : null,
      );

  /// Captured image path.
  String? get temporaryImagePath => _temporaryImagePath;
  String? _temporaryImagePath;
  set temporaryImagePath(String value) {
    if (_temporaryImagePath != value) {
      _temporaryImagePath = value;
      super.imagePath = value;
      //notifyListeners();
    }
  }

  Future saveTemporaryImage(XFile image, String path) async {
    // Captured image remains?
    if (temporaryImagePath != null) {
      final file = File(temporaryImagePath!);
      if (await file.exists()) {
        await file.delete();
      }
    }
    // Save image.
    image.saveTo(path);
    temporaryImagePath = path;
  }

  /* Event */
  Future captureIconPressed() async {
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
}
