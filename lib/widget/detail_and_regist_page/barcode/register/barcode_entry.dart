part of '../barcode_register.dart';

class BarcodeEntry extends StatelessWidget {
  /* Setting */
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
        // TODO:モバイル版を開発するとき実装（現状デスクトップ版のみ）
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
        keyboardType: TextInputType.number, // only number
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        validator: vm.textformValidated,
        onChanged: vm.textformChanged,
      ),
    );

    /* Rayout */
    final int steps = (2 - (MediaQuery.of(context).size.width ~/ _sectionWidth))
        .minmax(1, 2); // (minStep, maxStep)

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
