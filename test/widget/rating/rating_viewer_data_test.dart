import 'package:darq/darq.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ramyeon_counter/widget/rating/rating_viewer_data.dart';
import 'package:ramyeon_counter/widget/rating/rating_widget_base.dart';

void main() {
  group('rating', () {
    group('normal', () {
      group('int', () {
        for (int ratingInt in RangeIterable(
          RatingViewerData.min,
          RatingViewerData.max,
        )) {
          test(
            '$ratingInt',
            () => expect(RatingViewerData(ratingInt).rating, ratingInt),
          );
        }
      });
      group('double', () {
        for (double ratingDouble in RangeIterable(
          RatingViewerData.min * 2,
          RatingViewerData.max * 2 + 1,
        ).select((x, _) => (x / 2))) {
          test(
            '$ratingDouble',
            () => expect(RatingViewerData(ratingDouble).rating, ratingDouble),
          );
        }
      });
    });
    group('error', () {
      group('int', () {
        for (int ratingIntError in RangeIterable(1, 6)) {
          test('+-$ratingIntError', () {
            expect(
              () => RatingViewerData(RatingViewerData.min - ratingIntError),
              throwsRangeError,
              reason: '-',
            );
            expect(
              () => RatingViewerData(RatingViewerData.max + ratingIntError),
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
              () => RatingViewerData(RatingViewerData.min - ratingDoubleError),
              throwsRangeError,
              reason: '-',
            );
            expect(
              () => RatingViewerData(RatingViewerData.max + ratingDoubleError),
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
          var target = RatingViewerData(min);
          expect(target.star[0], RatingStarType.full);
          expect(target.star[1], RatingStarType.none);
        });
      }
    });
    group('max', () {
      for (num max in [10, 10.0]) {
        test('$max', () {
          var target = RatingViewerData(max);
          expect(target.star[8], RatingStarType.full);
          expect(target.star[9], RatingStarType.full);
        });
      }
    });
    group('half', () {
      test('5', () {
        var target = RatingViewerData(5);
        expect(target.star[4], RatingStarType.full);
        expect(target.star[5], RatingStarType.none);
      });
      test('5.4', () {
        var target = RatingViewerData(5.4);
        expect(target.star[4], RatingStarType.full);
        expect(target.star[5], RatingStarType.none);
        expect(target.star[6], RatingStarType.none);
      });
      test('5.5', () {
        var target = RatingViewerData(5.5);
        expect(target.star[4], RatingStarType.full);
        expect(target.star[5], RatingStarType.half);
        expect(target.star[6], RatingStarType.none);
      });
      test('5.6', () {
        var target = RatingViewerData(5.6);
        expect(target.star[4], RatingStarType.full);
        expect(target.star[5], RatingStarType.half);
        expect(target.star[6], RatingStarType.none);
      });
    });
  });
}
