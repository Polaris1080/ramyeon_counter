part of 'ramyeon_list_area.dart';

class const CatarogTile({super.key, required final RamyeonListData data})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //final color = data.packageColor != null ? Color(data.packageColor!) : null;
    return ListTile(
      leading: ExcludeSemantics(
        // TODO
        child: CircleAvatar(child: Text('${data.id}')),
      ),
      title: Text(data.brand, overflow: .clip, maxLines: 1),
      subtitle: Text(
        '☆${data.rating} \u{A5}-円', //${data.price}',
        overflow: .clip,
        maxLines: 1,
      ),
      onTap: () => {
        context.push(
          '/detail',
          extra: [
            data.id,
            data.packageColor,
            //color, //data.packageColor != null ? Color(data.packageColor!) : null,
          ],
        ),
      },
    );
  }
}
