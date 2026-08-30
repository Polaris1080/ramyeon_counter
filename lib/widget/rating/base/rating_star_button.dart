part of 'rating_widget_base.dart';

class RatingStarButton extends IconButton {
  new({
    super.key,
    required super.onPressed,
    required RatingStarType Function() evaluation,
  }) : super(
         icon: RatingStar.show(type: evaluation()),
         constraints: const BoxConstraints(),
         padding: EdgeInsetsGeometry.all(4),
       );
}
