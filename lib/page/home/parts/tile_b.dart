import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ramyeon_counter/models/context/ramyeon/ramyeon_list_data.dart';

class TileB extends StatelessWidget {
  const TileB({super.key, required this.data});

  final RamyeonListData data;

  @override
  Widget build(BuildContext context) {
    final color = data.packageColor != null ? Color(data.packageColor!) : null;
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
            data.packageColor
            //color, //data.packageColor != null ? Color(data.packageColor!) : null,
          ],
        ),
      },
    );
  }
}
