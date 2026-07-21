part of 'detail_bottom_appbar.dart';

class PageTwo extends StatelessWidget {
  /* Setting */
  static const _spacing = 10.0;

  const PageTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(_spacing),
      child: Wrap(
        alignment: .spaceEvenly,
        spacing: _spacing,
        runSpacing: _spacing,
        children: [
          ElevatedButton.icon(
            icon: const Icon(Icons.add),
            onPressed: () {
              showDialog<void>(
                context: context,
                builder: (BuildContext context) {
                  return AddDialog(productName: '神チャンソプ');
                },
              );
            },
            label: const Text('追加'),
          ),
          ElevatedButton.icon(
            icon: const Icon(Icons.remove),
            onPressed: () {
              showModalBottomSheet<void>(
                context: context,
                builder: (BuildContext context) {
                  return EatSheet();
                },
              );
            },
            label: const Text('消費'),
          ),
        ],
      ),
    );
  }
}
