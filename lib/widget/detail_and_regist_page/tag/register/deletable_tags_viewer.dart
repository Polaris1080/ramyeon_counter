part of '../tag_register.dart';

class DeletableTagsViewer extends TagsViewer {
  const DeletableTagsViewer({
    super.key,
    required super.source,
    required TagRegisterViewModel viewmodel,
  }) : vm = viewmodel;

  /* Value */
  @protected
  final TagRegisterViewModel vm;

  /* Widget */
  @protected
  @override
  Widget tagChip(BuildContext context, String source) =>
      FloatingActionButton.extended(
        heroTag: null,
        icon: Icon(Icons.close),
        label: Text(source),
        /* Delete dialog */
        onPressed: () => showDialog(
          context: context,
          builder: (context) {
            final definication = {
              'キャンセル': () {
                Navigator.pop(context);
              },
              '削除': () {
                vm.remove(1);
                Navigator.pop(context);
              },
            };

            return AlertDialog(
              title: const Text("削除しますか？"),
              content: Text(source),
              actions: definication.entries
                  .select(
                    (s, _) =>
                        TextButton(onPressed: s.value, child: Text(s.key)),
                  )
                  .toList(),
            );
          },
        ),
      );
}
