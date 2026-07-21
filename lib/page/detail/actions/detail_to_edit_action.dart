part of '../detail_page.dart';

class DetailToEditAction extends StatelessWidget {
  const DetailToEditAction(this.ramyeonId, this.packageColor, {super.key});

  /* Argument */
  final int ramyeonId;
  final Color? packageColor;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.edit),
      tooltip: '編集',
      onPressed: () {
        context.push(
          '/detail/edit/$ramyeonId',
          // Color渡しは対応していなかった（はず）
          extra: packageColor?.toARGB32(),
        );
      },
    );
  }
}
