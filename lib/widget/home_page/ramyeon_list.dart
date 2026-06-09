import 'package:darq/darq.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:ramyeon_counter/model/ramyeon.dart';
import 'package:ramyeon_counter/model/ramyeon_list_data.dart';
import 'package:ramyeon_counter/page/home_page.dart';
import 'package:ramyeon_counter/page/home_page_vm.dart';

import 'ramyeon_list_vm.dart';

class RamyeonList extends StatelessWidget {
  RamyeonList(
    List<RamyeonListData> view,
    this.orderBy,
    this.isCatalogMode, {
    super.key,
  }) {
    tile = sortedList(
      view.select((c, _) => RamyeonTileViewModel.fromModel(c)).toList(),
    );
  }

  final bool isCatalogMode;
  final RamyeonListOrder orderBy;
  late final List<RamyeonTileViewModel> tile;

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

  @override
  Widget build(BuildContext context) {
    return tile.isNotEmpty
        ? ListView.builder(
            // TODO ロゴ
            cacheExtent: 0.0,
            itemCount: tile.count(),
            itemBuilder: (context, index) {
              RamyeonTileViewModel tileVM = tile[index];
              return ListenableBuilder(
                listenable: tileVM,
                builder: (context, child) {
                  return isCatalogMode
                      ? ListTile(
                          leading: ExcludeSemantics(
                            // TODO ロゴ
                            child: CircleAvatar(child: Text('${tileVM.id}')),
                          ),
                          title: Text(
                            tileVM.brand,
                            overflow: .clip,
                            maxLines: 1,
                          ),
                          subtitle: Text(
                            'のこり${tileVM.count}個 ', // 期\ufeff限：\ufeff${DateFormat('yyyy年MM月dd日').format(tileVM.limit!)}',
                            overflow: .clip,
                            maxLines: 1,
                          ), //期限
                          isThreeLine: true,
                          onTap: () => {
                            context.push(
                              '/stock/${tileVM.id}',
                              extra: tileVM.ramyeon!.packageColor != null
                                  ? Color(tileVM.ramyeon!.packageColor!)
                                  : null,
                            ),
                          },
                        )
                      : ListTile(
                          leading: ExcludeSemantics(
                            // TODO
                            child: CircleAvatar(child: Text('${tileVM.id}')),
                          ),
                          title: Text(
                            tileVM.brand,
                            overflow: .clip,
                            maxLines: 1,
                          ),
                          subtitle: Text(
                            '☆${tileVM.rate} \u{A5}${tileVM.price}',
                            overflow: .clip,
                            maxLines: 1,
                          ),
                          onTap: () => {
                            context.push('/detail', extra: tileVM.ramyeon!),
                          },
                        );
                },
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
