part of '../barcode_register.dart';

class BarcodeEntry extends StatelessWidget {
  /* Setting */
  static final regexp = RegExp(r'^\d{8}$|^\d{13}$');
  static const _entryWidth = 170.0, _sectionWidth = 300.0, _spacing = 15.0;

  const BarcodeEntry(this.vm, {super.key});

  /* Value */
  @protected
  final BarcodeRegisterViewModel vm;

  @override
  Widget build(BuildContext context) {
    /* Widget */
    Widget addButton() => ListenableBuilder(
      listenable: vm,
      builder: (context, _) =>
          IconButton(icon: Icon(Icons.add), onPressed: vm.addButtonClicked()),
    );

    Widget scanButton() => IconButton(
      icon: Icon(Icons.barcode_reader),
      onPressed: switch (Platform.operatingSystem) {
        _ => null,
        // モバイル版を開発するとき実装（現状デスクトップ版のみ）
        // 想定：バーコードを読み込む
        //String os when os == "android" || os == "ios" => () {},
      },
    );

    Widget textField() => SizedBox(
      width: _entryWidth,
      child: TextFormField(
        maxLength: 13,
        autovalidateMode: .onUserInteraction,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'バーコード',
          helperText: '数字８／１３桁',
        ),
        onChanged: vm.textformChanged,
        // only number
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        validator: (value) => switch (value) {
          String value when !regexp.hasMatch(value) => '桁数が違います',
          _ => null,
        },
      ),
    );

    /* Rayout */
    // 段数
    const maxStep = 2, minStep = 1;
    final int steps =
        (maxStep - (MediaQuery.of(context).size.width ~/ _sectionWidth)).minmax(
          minStep,
          maxStep,
        );

    return switch (steps) {
      2 => Column(
        children: [
          textField(),
          Row(
            mainAxisSize: .min,
            spacing: _spacing,
            children: [scanButton(), addButton()],
          ),
        ],
      ),
      _ => Row(
        mainAxisAlignment: .center,
        spacing: _spacing,
        children: [scanButton(), textField(), addButton()],
      ),
    };
  }
}
