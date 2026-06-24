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
  const DetailPage({super.key, required this.ramyeonId, this.packageColor});

  final int ramyeonId;
  final Color? packageColor;

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
              context.push('/detail/edit/$ramyeonId', extra: packageColor);
            },
          ),
        ],
        overrideColor: packageColor,
      ),
      body: Center(
        child: Column(
          children: [
            /* 1st Row(Image/Data) */
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Wrap(
                    children: [
                      /* 1st Columu(Image) */
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
                                child: RamyeonImageViewer(
                                  packageColor: packageColor,
                                  ramyeonId: ramyeonId,
                                ),
                              );
                            },
                      ),
                      /* 2nd Columu(Data) */
                      Container(
                        constraints: BoxConstraints(
                          //minWidth: 180,
                          maxWidth: 240,
                        ),
                        //height: 200,
                        child: RamyeonDataViewer(ramyeonId: ramyeonId),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            /* 2nd Row(Tag) */
            RamyeonTagViewer(ramyeonId: ramyeonId),
            Spacer(),
          ],
        ),
      ),
      bottomNavigationBar: DetailBottomAppbar(
        packageColor,
        ramyeonId: ramyeonId,
      ),
    );
  }
}
