// Model
import 'package:ramyeon_counter/model/ramyeon_list_data.dart';
// Package
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
// Widget
import 'package:ramyeon_counter/page/detail/detail_bottom_appbar.dart';
import 'package:ramyeon_counter/widget/custom_app_bar.dart';
import 'package:ramyeon_counter/widget/detail_regist_page/data/ramyeon_data_viewer.dart';
import 'package:ramyeon_counter/widget/detail_regist_page/tag/tag_viewer.dart';
import 'package:ramyeon_counter/widget/ramyeon_image/ramyeon_image_viewer.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key, required this.ramyeon});

  final RamyeonListData ramyeon;

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
            RamyeonTagViewer(ramyeonId: ramyeon.id),
            Spacer(),
          ],
        ),
      ),
      bottomNavigationBar: DetailBottomAppbar(ramyeon, ramyeonId: ramyeon.id),
    );
  }
}
