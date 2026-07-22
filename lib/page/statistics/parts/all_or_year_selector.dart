part of '../statistics_page.dart';

// TODO:存在する年だけ選択できるように【要望】
class AllOrYearSelector extends StatelessWidget {
  /* Setting */
  static const _borderRadis = 20.0,
      _itemWidth = 60.0,
      _textFontFamily = "ZenMaruGothic",
      _focusFontSize = 18.0,
      _notfocusFontSize = 14.0;

  AllOrYearSelector(this.selected, {super.key, this.oldestYear});

  /// 年（null=全部）
  /// [onlyYear]変更したときリセット
  final ValueNotifier<int?> selected;

  /// 年別（false=全部）
  final ValueNotifier<bool> onlyYear = .new(false);

  /// 年（最古）
  final int? oldestYear;

  @override
  Widget build(BuildContext context) {
    /* Color Setting */
    final cs = ColorScheme.of(context),
        borderColor = cs.tertiary,
        borderColorBG = cs.tertiaryFixed,
        trackColor = Colors.white,
        trackColorOutline = cs.tertiaryContainer,
        trackColorSelected = cs.tertiaryFixedDim;

    onlyYear.addListener(() => selected.value = null);

    return Container(
      decoration: BoxDecoration(
        color: borderColorBG,
        border: Border.all(color: borderColor, width: 2.0),
        borderRadius: const .all(.circular(_borderRadis)),
      ),
      child: Row(
        mainAxisSize: .min,
        children: [
          /* Label */
          SizedBox(
            width: _itemWidth,
            child: ValueListenableBuilder(
              valueListenable: onlyYear,
              builder: (context, flag, _) => Text(
                "年別",
                textAlign: .center,
                style: .new(
                  color: cs.onTertiaryFixed,
                  fontSize: flag ? _notfocusFontSize : _focusFontSize,
                  fontFamily: _textFontFamily,
                ),
              ),
            ),
          ),
          /* Switch */
          SizedBox(
            width: _itemWidth,
            child: ValueListenableBuilder(
              valueListenable: onlyYear,
              builder: (context, flag, _) => Switch(
                thumbColor: WidgetStateProperty.fromMap({
                  WidgetState.selected: borderColor,
                  WidgetState.any: trackColorOutline,
                }),
                trackColor: WidgetStateProperty.fromMap({
                  WidgetState.selected: trackColorSelected,
                  WidgetState.any: trackColor,
                }),
                trackOutlineColor: WidgetStateProperty.fromMap({
                  WidgetState.any: trackColorOutline,
                }),
                value: flag,
                onChanged: (_) => onlyYear.flip(),
              ),
            ),
          ),
          /* Picker */
          SizedBox(
            width: _itemWidth,
            child: ValueListenableBuilder(
              valueListenable: onlyYear,
              builder: (context, flag, _) {
                final displaySize = MediaQuery.of(context).size,
                    select = selected.value,
                    nowYear = DateTime.now().year;
                return TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.transparent, // hover Color
                    padding: EdgeInsets.zero,
                  ),
                  onPressed: flag
                      ? () => showDialog(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            content: SizedBox(
                              width: displaySize.width * 0.8,
                              height: displaySize.height * 0.5,
                              child: YearPicker(
                                firstDate: DateTime(oldestYear ?? nowYear, 1),
                                lastDate: DateTime(nowYear, 1),
                                selectedDate: DateTime(select ?? nowYear, 1),
                                onChanged: (DateTime dateTime) {
                                  selected.value = dateTime.year;
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                          ),
                        )
                      : null,
                  child: Text(
                    '選択',
                    style: .new(
                      color: flag ? borderColor : trackColorSelected,
                      fontSize: flag ? _focusFontSize : _notfocusFontSize,
                      fontFamily: _textFontFamily,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
