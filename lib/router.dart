import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
// Model
import 'package:ramyeon_counter/model/ramyeon.dart';
// Page
import 'package:ramyeon_counter/page/detail/detail_page.dart';
import 'package:ramyeon_counter/page/history/history_page.dart';
import 'package:ramyeon_counter/page/home_page.dart';
import 'package:ramyeon_counter/page/regist/regist_page.dart';
import 'package:ramyeon_counter/page/stat_page.dart';
import 'package:ramyeon_counter/page/stock_page.dart';

final goRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', name: 'index', builder: (context, state) => HomePage()),
    // 詳細
    GoRoute(
      path: '/detail',
      name: 'detail',
      pageBuilder: (context, state) => MaterialPage(
        key: state.pageKey,
        child: DetailPage(ramyeon: state.extra as Ramyeon),
      ),
      routes: [
        // 編集
        GoRoute(
          path: 'edit/:brandId',
          name: 'edit',
          pageBuilder: (context, state) => MaterialPage(
            key: state.pageKey,
            child: RegistPage(
              brandId: int.parse(state.pathParameters['brandId']!),
              packageColor: state.extra as Color?,
            ),
          ),
        ),
        // 履歴：価格
        GoRoute(
          path: 'price/:brandId',
          name: 'history_price',
          pageBuilder: (context, state) => MaterialPage(
            key: state.pageKey,
            child: HistoryPricePage(
              brandId: int.parse(state.pathParameters['brandId']!),
              packageColor: state.extra as Color?,
            ),
          ),
        ),
        // 履歴：評価
        GoRoute(
          path: 'rating/:brandId',
          name: 'history_rating',
          pageBuilder: (context, state) => MaterialPage(
            key: state.pageKey,
            child: HistoryRatingPage(
              brandId: int.parse(state.pathParameters['brandId']!),
              packageColor: state.extra as Color?,
            ),
          ),
        ),
      ],
    ),
    // 履歴（全体）
    GoRoute(
      path: '/history/price',
      name: 'history_price_all',
      pageBuilder: (context, state) => MaterialPage(
        key: state.pageKey,
        child: HistoryPricePage(brandId: null),
      ),
    ),
    GoRoute(
      path: '/history/rating',
      name: 'history_rating_all',
      pageBuilder: (context, state) => MaterialPage(
        key: state.pageKey,
        child: HistoryRatingPage(brandId: null),
      ),
    ),
    // 登録
    GoRoute(
      path: '/regist',
      name: 'regist',
      pageBuilder: (context, state) =>
          MaterialPage(key: state.pageKey, child: RegistPage()),
    ),
    // 統計
    GoRoute(
      path: '/stat',
      name: 'stat',
      pageBuilder: (context, state) =>
          MaterialPage(key: state.pageKey, child: const StatPage()),
    ),
    // 在庫（全体）
    GoRoute(
      path: '/stock',
      name: 'stock_all',
      pageBuilder: (context, state) =>
          MaterialPage(key: state.pageKey, child: Stockpage(brandId: null)),
    ),
    // 在庫（個別）
    GoRoute(
      path: '/stock/:brandId',
      name: 'stock',
      pageBuilder: (context, state) => MaterialPage(
        key: state.pageKey,
        child: Stockpage(
          brandId: int.parse(state.pathParameters['brandId']!),
          packageColor: state.extra as Color?,
        ),
      ),
    ),
  ],
  // エラーが発生した時（例：遷移ページがない）このページに行く
  errorPageBuilder: (context, state) => MaterialPage(
    key: state.pageKey,
    child: Scaffold(body: Center(child: Text(state.error.toString()))),
  ),
);
