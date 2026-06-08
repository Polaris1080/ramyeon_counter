import 'package:flutter/material.dart';
import 'package:ramyeon_counter/widget/rating/selecter/rating_selecter.dart';

class EatSheet extends StatelessWidget {
  EatSheet({super.key});

  final ratingNotifier = ValueNotifier(1);

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
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }
}
