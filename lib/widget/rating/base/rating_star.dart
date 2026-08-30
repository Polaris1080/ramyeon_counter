part of 'rating_widget_base.dart';

abstract class const RatingStar(super.icon, {super.key, super.color})
    extends Icon {
  factory show({required RatingStarType type}) => switch (type) {
    .full => FullRatingStar(),
    .half => HalfRatingStar(),
    .none => NoneRatingStar(),
  };
}
