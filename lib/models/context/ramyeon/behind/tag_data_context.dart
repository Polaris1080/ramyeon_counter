// Base
import '../../../base/context_base.dart';
import '../../../database/ramyeon/ramyeon_database_tables.dart';

// Package
import 'package:darq/darq.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

// Model
import '../tag_data.dart';
import '../../../../ramyeon_database.dart';

class TagDataContext extends RamyeonContextBase {
  RamyeonDatabaseTables get table => .ramyeon;

  /// 共通部
  Future<({Iterable<String> tags, Map<int, int> ranks})> _getTags() async {
    const columu = 'tag';
    final database = await db;

    // タグ
    final Iterable<String> tags = (await database.query(
      table.name,
      columns: [columu],
    )).selectMany((s, _) => (s[columu] as String).split(','));

    return (
      tags: /* Iterable<String> */ tags,
      ranks: /* Map<int key, int value> */ tags
          // 個数を求める
          .groupBy((g) => g)
          .select((s, _) => s.elements.count())
          // 順位に変換する
          .distinct()
          .orderByDescending((count) => count)
          .select((s, i) => (count: s, rank: i + 1))
          .toMap((t) => MapEntry(t.count, t.rank)),
    );
  }

  Future<List<TagData>> readAllTagData() async {
    final (:tags, :ranks) = await _getTags();
    return tags
        .getCount // 個数を求める
        .orderBy((o) => o.tag) // 並び替え
        .castData(ranks); // Dataに変換する
  }

  Future<List<TagData>> readRankingTagData({int? limit}) async {
    final (:tags, :ranks) = await _getTags();
    return tags
        .getCount // 個数を求める
        .orderByDescending((o) => o.count) // 並び替え
        .thenBy((t) => t.tag)
        .take(limit ?? -1 >>> 1) // if limit is null, int.maxValue
        .castData(ranks); // Dataに変換する
  }
}

class TestTagDataContext extends TagDataContext {
  @override
  Future<Database> get db => TestRamyeonDatabase().open();
}

extension on Iterable<String> {
  /// 個数を求める
  Iterable<({int count, String tag})> get getCount =>
      groupBy((g) => g)
          .select((s, _) => (tag: s.key, count: s.elements.count()));
}

extension on Iterable<({int count, String tag})> {
  /// Dataに変換する
  List<TagData> castData(Map<int, int> ranks) => select(
    (s, i) => TagData(tag: s.tag, rank: ranks[s.count]!, count: s.count),
  ).toList();
}
