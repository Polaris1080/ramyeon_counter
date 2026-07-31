part of '../tag_register.dart';

class DeletableTagsViewer extends StatelessWidget {
  static const _horizontalSpacing = 10.0,
      _verticalSpacing = 10.0,
      _alertTitle = "削除しますか？",
      _alertCancel = "Cancel",
      _alertOK = "OK";

  const DeletableTagsViewer(this.vm, {super.key});

  final TagRegisterViewModel vm;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: vm,
      builder: (context, child) => Wrap(
        spacing: _horizontalSpacing,
        runSpacing: _verticalSpacing,
        children: vm.tag
            .select(
              (text, at) => FloatingActionButton.extended(
                heroTag: null,
                icon: Icon(Icons.close),
                label: Text(text),
                /* 削除ダイアログ */
                onPressed: () => showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text(_alertTitle),
                    content: Text(text),
                    actions: [
                      TextButton(
                        child: const Text(_alertCancel),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      TextButton(
                        child: const Text(_alertOK),
                        onPressed: () {
                          vm.remove(at);
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
