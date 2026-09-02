// Annotation
import 'package:ramyeon_counter/utility/annotations/viewmodel_annotation.dart';

// Package
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// Widget
import 'package:ramyeon_counter/widget/rating/rating_viewer.dart';

// Partial
part 'ramyeon_data_viewer_data.dart';

class const RamyeonDataViewer({
  super.key,
  required final RamyeonDataViewerData data,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final tt = TextTheme.of(context);
    return Column(
      mainAxisSize: .min,
      children: [
        Text(
          data.brand,
          style: tt.titleLarge!.copyWith(fontFamily: 'ZenKakuGothicNew'),
        ),
        Padding(
          padding: .only(
            top: 5.0, //【Upper spacing】
            bottom: 10.0, //【Lower spacing】
          ),
          child: RatingViewer(vm: .new(data.rate)),
        ),
        Text(
          data.price,
          style: tt.bodyLarge!.copyWith(fontFamily: 'ZenMaruGothic'),
        ),
        Text(
          data.date,
          style: tt.bodyLarge!.copyWith(fontFamily: 'ZenMaruGothic'),
        ),
      ],
    );
  }
}
