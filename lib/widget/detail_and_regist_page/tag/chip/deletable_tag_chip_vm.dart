part of 'deletable_tag_chip.dart';

class DeletableTagChipViewModel({
  required super.data,
  final Function()? _onDeleted,
}) extends TagChipViewModel {
  /// Delete icon pressed.
  @OneTime()
  Function()? get onIconPressed => _onDeleted;

  /// Chip body pressed
  @OneTime()
  Function()? get onBodyPressed => _onDeleted == null ? () {} : null;
}
