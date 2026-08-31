part of '../tag_register.dart';

class const DeletableTagsViewer({
  super.key,
  required super.source,
  required final TagRegisterViewModel vm,
}) extends TagsViewer {
  @protected
  @override
  Widget tagChip(String source) => Builder(
    builder: (context) => DeletableTagChip(
      vm: .new(
        data: source,
        /* Delete dialog */
        onDeleted: () => showDialog(
          context: context,
          builder: (_) {
            final definication = {
              'キャンセル': () {
                Navigator.pop(context);
              },
              '削除': () {
                vm.removeSource(1);
                Navigator.pop(context);
              },
            };

            return AlertDialog(
              title: const Text("削除しますか？"),
              content: Text(source),
              actions: definication.entries
                  .map(
                    (e) => TextButton(onPressed: e.value, child: Text(e.key)),
                  )
                  .toList(),
            );
          },
        ),
      ),
    ),
  );
}
