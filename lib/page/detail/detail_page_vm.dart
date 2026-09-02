/// @docImport 'package:ramyeon_counter/widget/detail_and_regist_page/tag/tag_viewer.dart';
library;

// Annotation
import 'package:ramyeon_counter/utility/annotations/viewmodel_annotation.dart';

// Package
import 'package:flutter/material.dart';

// Relation
import 'package:ramyeon_counter/page/detail/detail_page_context.dart';

// Widget
import 'package:ramyeon_counter/widget/detail_and_regist_page/data/ramyeon_data_viewer.dart';

class DetailPageViewModel({required final int ramyeonId})
    extends ChangeNotifier {
  /// [RamyeonDataViewer] context.
  @OneWay()
  RamyeonDataViewerData get data => _data;
  RamyeonDataViewerData _data = .new();

  /// [TagsViewer] content.
  @OneWay()
  Set<String> get tag => _tag;
  Set<String> _tag = .new();

  /* Command */
  Future get loadDataViewerData async {
    final (price, date) = await DetailPageContext().readPriceAverage(ramyeonId);
    _data = .new(
      brand: await DetailPageContext().readBrand(ramyeonId),
      rate: await DetailPageContext().averageByBrandId(ramyeonId),
      price: price,
      date: date,
    );
    notifyListeners();
  }

  Future get loadTagsViewerData async {
    _tag = await DetailPageContext().readTag(ramyeonId);
    notifyListeners();
  }
}
