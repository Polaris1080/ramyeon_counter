import 'dart:math';

import 'package:darq/darq.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ramyeon_counter/model/context/ramyeon_list_data_context.dart';
import 'package:ramyeon_counter/model/ramyeon_list_data.dart';
import 'package:ramyeon_counter/page/home/home_page.dart';

class RamyeonListView extends StatelessWidget {
  RamyeonListView(
    //List<RamyeonListData> view,
    this.limit,
    this.orderBy,
    this.isCatalogMode, {
    super.key,
  }) : assert(limit > 0),
       cou = .new(limit);

  final int limit;
  final bool isCatalogMode;
  final RamyeonListOrder orderBy;

  final ValueNotifier<int> cou;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: cou,
      builder: (context, value, child) {
        return NotificationListener<ScrollEndNotification>(
          onNotification: (ScrollEndNotification notification) {
            final isScrollToEnd = notification.metrics.extentAfter == 0;

            if (isScrollToEnd) {
              cou.value++;
            }
            return false;
          },
          child: ListView.builder(
            itemCount: min(limit, cou.value),
            itemBuilder: (context, index) {
              //RamyeonTileViewModel tileVM = tile[index];
              return FutureBuilder(
                future: RamyeonListDataContext().readBy("brand", index),
                builder: (context, snapshot) {
                  return switch (snapshot.data) {
                    RamyeonListData data =>
                      isCatalogMode ? TileA(data: data) : TileB(data: data),
                    _ => SizedBox(),
                  };
                },
              );
            },
          ),
        );
      },
    );
  }
}

class TileB extends StatelessWidget {
  const TileB({super.key, required this.data});

  final RamyeonListData data;

  @override
  Widget build(BuildContext context) {
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
          extra: (
            data.id,
            data.packageColor != null ? Color(data.packageColor!) : null,
          ),
        ),
      },
    );
  }
}

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
