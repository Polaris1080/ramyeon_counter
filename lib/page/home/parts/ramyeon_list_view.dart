import 'dart:math';

import 'package:darq/darq.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ramyeon_counter/model/context/ramyeon_list_data_context.dart';
import 'package:ramyeon_counter/model/ramyeon_list_data.dart';
import 'package:ramyeon_counter/page/home/home_page.dart';

import 'ramyeon_list_view_vm.dart';

class RamyeonListView extends StatelessWidget {
  RamyeonListView(
    //List<RamyeonListData> view,
    this.limit,
    this.orderBy,
    this.isCatalogMode, {
    super.key,
  }) {
    // tile = sortedList(
    //   view.select((c, _) => RamyeonTileViewModel.fromModel(c)).toList(),
    // );
  }

  final int limit;
  final bool isCatalogMode;
  final RamyeonListOrder orderBy;
  //late final List<RamyeonTileViewModel> tile;

  List<RamyeonTileViewModel> sortedList(List<RamyeonTileViewModel> value) {
    value.sort(
      (a, b) => switch (orderBy) {
        .normal => a.brand.compareTo(b.brand),
        .rating => a.rate!.compareTo(b.rate!),
        .price => a.price!.compareTo(b.price!),
        .count => a.count!.compareTo(b.count!),
        .limit => a.limit!.compareTo(b.limit!),
      },
    );
    return value;
  }

  final ValueNotifier<int> cou = .new(5);

  @override
  Widget build(BuildContext context) {
    return true //tile.isNotEmpty
        ? ValueListenableBuilder(
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
                            isCatalogMode
                                ? TileA(data: data)
                                : TileB(data: data),
                          _ => SizedBox(),
                        };
                      },
                    );
                  },
                ),
              );
            },
          )
        // 結果なし(vm.tile is empty)
        : Center(
            child: Text(
              '見つかりません',
              style: TextStyle(
                fontFamily: 'ZenKakuGothic',
                fontSize: 24,
                fontWeight: .w500,
              ),
            ),
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
