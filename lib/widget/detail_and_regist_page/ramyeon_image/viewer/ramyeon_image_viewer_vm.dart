part of 'ramyeon_image_viewer.dart';

class RamyeonImageViewerViewModel({required super.brandId})
    extends RamyeonImageBaseViewModel {
  /* Command */
  void onDetailButtonPressed(BuildContext context) => Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => RamyeonImageViewerDetail(Image.file(.new(imagePath!))),
    ),
  );
}
