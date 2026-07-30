part of '../barcode_register.dart';

class BarcodeEntry extends StatelessWidget {
  static const _entryWidth = 170.0, _sectionWidth = 300.0, _spacing = 15.0;

  const BarcodeEntry(this.vm, {super.key});

  final BarcodeRegisterViewModel vm;

  @override
  Widget build(BuildContext context) {
    return switch (MediaQuery.of(context).size.width) {
      /* displayWidth >= sectionWidth => 1段 */
      double displayWidth when displayWidth >= _sectionWidth => Row(
        mainAxisAlignment: .center,
        spacing: _spacing,
        children: [
          _scan(),
          _entry(),
          IconButton(onPressed: vm.append, icon: Icon(Icons.add)),
        ],
      ),
      /* displayWidth <  sectionWidth => 2段 */
      _ => Column(
        children: [
          _entry(),
          Row(
            mainAxisSize: .min,
            spacing: _spacing,
            children: [_scan(), _add()],
          ),
        ],
      ),
    };
  }

  IconButton _add() => IconButton(onPressed: vm.append, icon: Icon(Icons.add));

  IconButton _scan() => IconButton(
    onPressed: switch (Platform.operatingSystem) {
      _ => null,
      // モバイル版を開発するとき実装（現状デスクトップ版のみ）
      // 想定：バーコードを読み込む
      //String os when os == "android" || os == "ios" => () {},
    },
    icon: Icon(Icons.barcode_reader),
  );

  SizedBox _entry() {
    final regexp = RegExp(r'^\d{8}$|^\d{13}$');

    return SizedBox(
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
        validator: (value) {
          if (value != null && value.isNotEmpty && !regexp.hasMatch(value)) {
            return '桁数が違います';
          }
          return null;
        },
      ),
    );
  }
}
