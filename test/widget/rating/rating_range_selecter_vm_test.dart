import 'package:flutter_test/flutter_test.dart';
import 'package:ramyeon_counter/widget/rating/selecter/rating_range_selecter_vm.dart';

void main() {
  RatingRangeSelecterViewModel target = .new();

  final List<int> command = [2, 9, 6, 4, 5, 6, 5, 4, 5];

  test('min:1→2/max:10', () {
    target.ratingChanged(command[0]);
    expect(target.min, command[0]);
    expect(target.max, 10);
  });

  test('min:2/max:10→9', () {
    target.ratingChanged(command[1]);
    expect(target.min, command[0]);
    expect(target.max, command[1]);
  });

  test('min:2/max:9→6', () {
    target.ratingChanged(command[2]);
    expect(target.min, command[0]);
    expect(target.max, command[2]);
  });

  test('min:2→4/max:6', () {
    target.ratingChanged(command[3]);
    expect(target.min, command[3]);
    expect(target.max, command[2]);
  });

  test('min:4→5/max:6→5', () {
    target.ratingChanged(command[4]);
    expect(target.min, command[4]);
    expect(target.max, command[4]);
  });

  test('min:5/max:5→6', () {
    target.ratingChanged(command[5]);
    expect(target.min, command[4]);
    expect(target.max, command[5]);
  });

  test('min:5/max:6→5', () {
    target.ratingChanged(command[6]);
    expect(target.min, command[6]);
    expect(target.max, command[6]);
  });

  test('min:5→4/max:5', () {
    target.ratingChanged(command[7]);
    expect(target.min, command[7]);
    expect(target.max, command[6]);
  });

  test('min:4→5/max:5', () {
    target.ratingChanged(command[8]);
    expect(target.min, command[8]);
    expect(target.max, command[8]);
  });
}
