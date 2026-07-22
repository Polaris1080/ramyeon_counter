part of 'ramyeon_image_viewer.dart';

class RamyeonImageViewerDetail extends StatelessWidget {
  /* Setting */
  static const _padding = 20.0,
      _imageSize = BoxConstraints(maxWidth: 1024, maxHeight: 1024);

  const RamyeonImageViewerDetail(this.image, {super.key});

  /* Argument */
  /// [RamyeonImageViewer] image
  final Image image;

  @override
  Widget build(BuildContext context) {
    final buttonStyle = OutlinedButton.styleFrom(
      // Color
      side: .new(color: Colors.grey, width: 2.0),
      foregroundColor: Colors.black,
      backgroundColor: Colors.white,
      // Other
      padding: .all(15),
      textStyle: Theme.of(context).textTheme.titleLarge!,
    );
    void backCommand() => Navigator.pop(context);

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Padding(
          padding: const .all(_padding),
          child: Hero(
            tag: RamyeonImageBase.heroTag,
            child: Container(
              constraints: _imageSize,
              child: GestureDetector(onTap: backCommand, child: image),
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        child: Center(
          child: OutlinedButton.icon(
            style: buttonStyle,
            icon: const Icon(Icons.arrow_back),
            label: const Text('戻る'),
            onPressed: backCommand,
          ),
        ),
      ),
    );
  }
}
