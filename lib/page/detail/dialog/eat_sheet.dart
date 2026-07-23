import 'package:flutter/material.dart';
import 'package:ramyeon_counter/model/rating.dart';
import 'package:ramyeon_counter/model/repository/rating_repository.dart';
import 'package:ramyeon_counter/utility/extention_type/ramyeon_id.dart';
import 'package:ramyeon_counter/widget/rating/selecter/rating_selecter.dart';

class EatSheet extends StatelessWidget {
  EatSheet({super.key, required this.id});

  final ratingNotifier = ValueNotifier(1);
  final RamyeonId id;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Text('いかがでしたか？'),
            RatingSelecter(ratingNotifier),
            ElevatedButton(
              child: const Text('Close BottomSheet'),
              onPressed: () {
                RatingRepository().consume(id, ratingNotifier.value);

                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
