// Package
import 'package:darq/darq.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
// Model
import '../tag_data.dart';
import '../base/context_base.dart';
import '../../ramyeon_database.dart';

class TagDataContext extends RamyeonContextBase {
  @override
  RamyeonDatabaseTable get table => .ramyeon;

  Future<List<TagData>> readAll({int? limit}) async {
    final database = await db;
    final tags = (await database.query(
      table.name,
      columns: ['tag'],
    )).selectMany((q, _) => (q['tag'] as String).split(','));

    // Key:個数|Value:順位
    final ranks = tags
        // 個数を求める
        .groupBy((t) => t)
        .select((t, _) => t.elements.count())
        // 順位に変換する
        .distinct()
        .orderByDescending((count) => count)
        .select((c, i) => (count: c, rank: i + 1))
        .toMap((x) => MapEntry(x.count, x.rank));

    // ここまで共通
    var tagData = tags
        // 個数を求める
        .groupBy((t) => t)
        .select((t, _) => (tag: t.key, count: t.elements.count()))
        // Dataに変換する
        .orderByDescending((c) => c.count)
        .select(
          (c, i) => TagData(tag: c.tag, rank: ranks[c.count]!, count: c.count),
        )
        .toList();

    return tagData;
  }

  Future<List<TagData>> readRanking({int? limit}) async {
    final database = await db;
    final tags = (await database.query(
      table.name,
      columns: ['tag'],
    )).selectMany((q, _) => (q['tag'] as String).split(','));

    // Key:個数|Value:順位
    final ranks = tags
        // 個数を求める
        .groupBy((t) => t)
        .select((t, _) => t.elements.count())
        // 順位に変換する
        .distinct()
        .orderByDescending((count) => count)
        .select((c, i) => (count: c, rank: i + 1))
        .toMap((x) => MapEntry(x.count, x.rank));

    // ここまで共通
    var tagData = tags
        // 個数を求める
        .groupBy((t) => t)
        .select((t, _) => (tag: t.key, count: t.elements.count()))
        // Dataに変換する
        .orderByDescending((c) => c.count)
        .take(limit ?? -1 >>> 1) // if limit is null, int.maxValue
        .select(
          (c, i) => TagData(tag: c.tag, rank: ranks[c.count]!, count: c.count),
        )
        .toList();

    return tagData;
  }
}

class TestTagDataContext extends TagDataContext {
  @override
  Future<Database> get db => TestRamyeonDatabase().open();
}
