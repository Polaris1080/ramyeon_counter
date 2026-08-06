import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ramyeon_counter/models/context/ramyeon_list_data.dart';

class TileA extends StatelessWidget {
  const TileA({super.key, required this.data});

  final RamyeonListData data;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ExcludeSemantics(
        // TODO ロゴ
        child: CircleAvatar(child: Text('${data.id}')),
      ),
      title: Text(data.brand, overflow: .clip, maxLines: 1),
      subtitle: Text(
        'のこり${data.count}個 ', // 期\ufeff限：\ufeff${DateFormat('yyyy年MM月dd日').format(tileVM.limit!)}',
        overflow: .clip,
        maxLines: 1,
      ), //期限
      isThreeLine: true,
      onTap: () => {
        context.push(
          '/stock/${data.id}',
          extra: data.packageColor != null ? Color(data.packageColor!) : null,
        ),
      },
    );
  }
}
