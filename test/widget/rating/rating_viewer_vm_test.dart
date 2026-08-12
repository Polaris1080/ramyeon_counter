import 'package:darq/darq.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ramyeon_counter/widget/rating/rating_viewer.dart';
import 'package:ramyeon_counter/widget/rating/rating_widget_base.dart';

void main() {
  group('rating', () {
    group('normal', () {
      group('int', () {
        for (int ratingInt in RangeIterable(
          RatingWidgetBase.min,
          RatingWidgetBase.max,
        )) {
          test(
            '$ratingInt',
            () => expect(RatingViewerViewModel(ratingInt).rating, ratingInt),
          );
        }
      });
      group('double', () {
        for (double ratingDouble in RangeIterable(
          RatingWidgetBase.min * 2,
          RatingWidgetBase.max * 2 + 1,
        ).select((x, _) => (x / 2))) {
          test(
            '$ratingDouble',
            () => expect(
              RatingViewerViewModel(ratingDouble).rating,
              ratingDouble,
            ),
          );
        }
      });
    });
    group('error', () {
      group('int', () {
        for (int ratingIntError in RangeIterable(1, 6)) {
          test('+-$ratingIntError', () {
            expect(
              () =>
                  RatingViewerViewModel(RatingWidgetBase.min - ratingIntError),
              throwsRangeError,
              reason: '-',
            );
            expect(
              () =>
                  RatingViewerViewModel(RatingWidgetBase.max + ratingIntError),
              throwsRangeError,
              reason: '+',
            );
          });
        }
      });
      group('double', () {
        for (double ratingDoubleError in RangeIterable(
          1,
          6,
        ).select((x, _) => x / 2)) {
          test('+-$ratingDoubleError', () {
            expect(
              () => RatingViewerViewModel(
                RatingWidgetBase.min - ratingDoubleError,
              ),
              throwsRangeError,
              reason: '-',
            );
            expect(
              () => RatingViewerViewModel(
                RatingWidgetBase.max + ratingDoubleError,
              ),
              throwsRangeError,
              reason: '+',
            );
          });
        }
      });
    });
  });

  group('star', () {
    group('min', () {
      for (num min in [1, 1.0]) {
        test('$min', () {
          var target = RatingViewerViewModel(min);
          expect(target.star[0], RatingStarType.full);
          expect(target.star[1], RatingStarType.none);
        });
      }
    });
    group('max', () {
      for (num max in [10, 10.0]) {
        test('$max', () {
          var target = RatingViewerViewModel(max);
          expect(target.star[8], RatingStarType.full);
          expect(target.star[9], RatingStarType.full);
        });
      }
    });
    group('half', () {
      test('5', () {
        var target = RatingViewerViewModel(5);
        expect(target.star[4], RatingStarType.full);
        expect(target.star[5], RatingStarType.none);
      });
      test('5.4', () {
        var target = RatingViewerViewModel(5.4);
        expect(target.star[4], RatingStarType.full);
        expect(target.star[5], RatingStarType.none);
        expect(target.star[6], RatingStarType.none);
      });
      test('5.5', () {
        var target = RatingViewerViewModel(5.5);
        expect(target.star[4], RatingStarType.full);
        expect(target.star[5], RatingStarType.half);
        expect(target.star[6], RatingStarType.none);
      });
      test('5.6', () {
        var target = RatingViewerViewModel(5.6);
        expect(target.star[4], RatingStarType.full);
        expect(target.star[5], RatingStarType.half);
        expect(target.star[6], RatingStarType.none);
      });
    });
  });
}
