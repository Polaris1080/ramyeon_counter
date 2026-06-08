import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ramyeon_counter/model/ramyeon.dart';
import 'package:ramyeon_counter/page/detail/detail_bottom_appbar.dart';
import 'package:ramyeon_counter/widget/add_dialog.dart';
import 'package:ramyeon_counter/widget/custom_app_bar.dart';
import 'package:ramyeon_counter/widget/detail_regist_page/tag/tag_viewer.dart';
import 'package:ramyeon_counter/widget/ramyeon_image/ramyeon_image_viewer.dart';
import 'package:ramyeon_counter/widget/eat_sheet.dart';
import 'package:ramyeon_counter/widget/rating/rating_viewer.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key, required this.ramyeon});

  final Ramyeon ramyeon;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(
        context,
        '詳細',
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            tooltip: '編集',
            onPressed: () {
              context.push(
                '/detail/edit/${ramyeon.id}',
                extra: ramyeon.packageColor != null
                    ? Color(ramyeon.packageColor!)
                    : null,
              );
            },
          ),
        ],
        overrideColor: ramyeon.packageColor != null
            ? Color(ramyeon.packageColor!)
            : null,
      ),
      //AppBar(title: const Text('詳細')),
      body: Center(
        child: Column(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Wrap(
                    children: [
                      LayoutBuilder(
                        builder:
                            (BuildContext context, BoxConstraints constraints) {
                              return Container(
                                constraints: BoxConstraints(
                                  minWidth: 96,
                                  minHeight: 96,
                                  maxWidth: 256,
                                  maxHeight: 256,
                                ),
                                height:
                                    MediaQuery.of(context).size.width * 0.25,
                                child: RamyeonImageViewer(ramyeon: ramyeon),
                              );
                            },
                      ),
                      Container(
                        constraints: BoxConstraints(
                          //minWidth: 180,
                          maxWidth: 240,
                        ),
                        //height: 200,
                        child: RamyeonDataViewer(ramyeon: ramyeon),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            RamyeonTagViewer(ramyeon: ramyeon),
            Spacer(),
          ],
        ),
      ),
      bottomNavigationBar: DetailBottomAppbar(ramyeon),
    );
  }
}

class RamyeonDataViewer extends StatelessWidget {
  const RamyeonDataViewer({super.key, required this.ramyeon});

  final Ramyeon ramyeon;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: .min,
      spacing: 8,
      children: [
        Text(ramyeon.brand),
        RatingViewer(5.5),
        Text('価格133円'),
        Text('期間2025/4/31-2026/4/31'),
      ],
    );
  }
}
