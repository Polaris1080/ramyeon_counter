// Package
import 'package:flutter/material.dart';
// Widget
import 'package:ramyeon_counter/page/detail/buttom/detail_bottom_appbar.dart';
import 'package:ramyeon_counter/page/detail/detail_page_vm.dart';
import 'package:ramyeon_counter/widget/custom_appbar/default_app_bar.dart';
import 'package:ramyeon_counter/widget/detail_and_regist_page/data/ramyeon_data_viewer.dart';
import 'package:ramyeon_counter/widget/detail_and_regist_page/tag/tag_viewer.dart';
import 'package:ramyeon_counter/widget/other/image_background.dart';
import 'package:ramyeon_counter/widget/detail_and_regist_page/ramyeon_image/viewer/ramyeon_image_viewer.dart';

// Other
import 'actions/base/detail_page_action.dart';

// ignore: prefer_const_constructors_in_immutables
class DetailPage({super.key, required this.ramyeonId, this.packageColor})
    extends StatelessWidget {
  final int ramyeonId;
  final Color? packageColor;

  final DetailPageViewModel vm = .new(ramyeonId: ramyeonId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(
        context,
        '詳細',
        actions: [
          DetailToEditAction(
            vm: .new(id: ramyeonId, color: packageColor),
          ),
        ],
      ),
      body: ImageBackground(
        vm: .paper(),
        child: Column(
          crossAxisAlignment: .stretch,
          children: [
            /* 1st Row(Image/Data) */
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
                            height: MediaQuery.of(context).size.width * 0.25,
                            child: RamyeonImageViewer(
                              vm: .new(brandId: ramyeonId),
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
                    child: FutureBuilder(
                      future: vm.loadDataViewerData,
                      builder: (_, _) => RamyeonDataViewer(data: vm.data),
                    ),
                  ),
                ],
              ),
            ),
            /* 2nd Row(Tag) */
            FutureBuilder(
              future: vm.loadTagsViewerData,
              builder: (_, _) => TagsViewer(source: vm.tag),
            ),
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
