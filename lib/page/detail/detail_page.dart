// Model
import 'package:ramyeon_counter/model/ramyeon_list_data.dart';
// Package
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ramyeon_counter/model/repository/ramyeon_repository.dart';
// Widget
import 'package:ramyeon_counter/page/detail/buttom/detail_bottom_appbar.dart';
import 'package:ramyeon_counter/utility/extension_type/ramyeon_id.dart';
import 'package:ramyeon_counter/widget/custom_app_bar.dart';
import 'package:ramyeon_counter/widget/detail_and_regist_page/data/ramyeon_data_viewer.dart';
import 'package:ramyeon_counter/widget/detail_and_regist_page/tag/tags_viewer.dart';
import 'package:ramyeon_counter/widget/image_background.dart';
import 'package:ramyeon_counter/widget/detail_and_regist_page/ramyeon_image/viewer/ramyeon_image_viewer.dart';
// Partical
part 'actions/detail_to_edit_action.dart';

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
        actions: [DetailToEditAction(ramyeonId, packageColor)],
        overrideColor: packageColor,
      ),
      body: ImageBackground.paper(
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
                              context,
                              ramyeonId,
                              packageColor: packageColor,
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
            /* 2nd Row(Tag) */
            FutureBuilder(
              future: RamyeonRepository().readTag(RamyeonId(ramyeonId)),
              builder: (context, snapshot) => switch (snapshot.data) {
                List<String> tags => TagsViewer(source: tags),
                _ => const SizedBox(),
              },
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
