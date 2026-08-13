part of 'ramyeon_image_viewer.dart';

class RamyeonImageViewerViewModel extends RamyeonImageBaseViewModel {
  RamyeonImageViewerViewModel({required super.brandId});

  void onOverlayButtonPressed(BuildContext context) => Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => RamyeonImageViewerDetail(Image.file(.new(imagePath!))),
    ),
  );
}
