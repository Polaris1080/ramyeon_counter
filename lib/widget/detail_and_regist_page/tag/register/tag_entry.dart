part of 'tag_register.dart';

class TagEntry extends StatelessWidget {
  TagEntry(this.vm, {super.key}) : tf = '';

  final TagRegisterViewModel vm;
  String tf;

  @override
  Widget build(BuildContext context) {
    final regexp = RegExp(r'^[\u3040-\u30ff]{3,5}$');

    return Row(
      children: [
        IconButton(
          onPressed: () {
            vm.append(2, tf);
          },
          icon: Icon(Icons.add),
        ),
        Expanded(
          child: TextFormField(
            maxLength: 5,
            autovalidateMode: .onUserInteraction,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'タグ',
              helperText: 'ひらがな・カタカナ／３～５文字',
            ),
            onChanged: (value) {
              tf = value;
            },
            validator: (value) {
              if (value != null &&
                  value.isNotEmpty &&
                  !regexp.hasMatch(value)) {
                return '形式が違います';
              }
              return null;
            },
          ),
        ),
      ],
    );
  }
}
