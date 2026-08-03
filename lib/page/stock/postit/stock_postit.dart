part of '../stock_page.dart';

class StockPostit extends Postit {
  /* Setting */
  static const size = Postit.defaultSize,
      _header = ['購入日', '賞味期限', '価格'],
      _postitContentPadding = 5.0;

  StockPostit(
    super.context, {
    super.key,
    required ValueNotifier<bool> isSelectMode,
    required ValueNotifier<bool> isSelected,
    required StockPostitData data,
  }) : super(
         color: data.color,
         /* Build */
         child: Builder(
           builder: (context) {
             /* Style */
             final tt = Theme.of(context).textTheme,
                 dt = DateFormat('yyyy年MM月dd日');

             /* Widget */
             Widget layout(
               TextSpan textSpan, {
               required List<Widget> children,
             }) => switch ((TextPainter(
                   text: textSpan,
                   textDirection: Directionality.of(context),
                 )..layout(
                   minWidth: 0,
                   maxWidth: size.width - _postitContentPadding * 2,
                 ))
                 .computeLineMetrics()
                 .length) {
               > 1 => Column(crossAxisAlignment: .stretch, children: children),
               _ => Row(mainAxisAlignment: .spaceBetween, children: children),
             };

             return Stack(
               children: [
                 Padding(
                   padding: const EdgeInsets.all(_postitContentPadding),
                   child: Column(
                     children: [
                       /* title */
                       Text(
                         data.brand,
                         style: tt.titleSmall!.copyWith(
                           fontFamily: "ZenKakuGothicNew",
                         ),
                       ),
                       Spacer(),
                       /* term */
                       ..._header.select((s, _) => '$s：').zip(
                         [
                           dt.format(data.expirationDate),
                           dt.format(data.purchaseDate),
                           '${data.price}円',
                         ],
                         (heading, content) => layout(
                           TextSpan(text: "$heading$content"),
                           children: [
                             Text(
                               heading,
                               textAlign: .start,
                               style: tt.labelLarge!.copyWith(
                                 color: Colors.black,
                               ),
                             ),
                             Text(
                               content,
                               textAlign: .end,
                               style: tt.bodyMedium!.copyWith(
                                 color: Colors.black,
                                 fontFamily: "ZenKakuGothicNew",
                               ),
                             ),
                           ],
                         ),
                       ),
                     ],
                   ),
                 ),
                 /* CheckBox */
                 ValueListenableBuilder(
                   valueListenable: isSelectMode,
                   builder: (context, flag, w) =>
                       Visibility(visible: flag, child: w!),
                   child: Align(
                     alignment: Alignment.topRight,
                     child: ValueListenableBuilder(
                       valueListenable: isSelected,
                       builder: (context, flag, _) => Checkbox(
                         // Color
                         checkColor: Colors.green[700],
                         fillColor: WidgetStateColor.resolveWith(
                           (_) => Colors.white,
                         ),
                         side: WidgetStateBorderSide.resolveWith(
                           (_) => BorderSide(width: 2.0, color: Colors.black87),
                         ),
                         // Other
                         value: flag,
                         onChanged: (_) => isSelected.flip(),
                       ),
                     ),
                   ),
                 ),
               ],
             );
           },
         ),
       );
}
