part of '../tag_register.dart';

class const TagEntry(final TagRegisterViewModel vm, {super.key})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /* Widget */
    Widget addButton() =>
        IconButton(icon: Icon(Icons.add), onPressed: vm.addButtonClicked());

    Widget textField() => Expanded(
      child: TextFormField(
        maxLength: 5,
        autovalidateMode: .onUserInteraction,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'タグ',
          helperText: 'ひらがな・カタカナ／３～５文字',
        ),
        validator: vm.textformValidated,
        onChanged: vm.textformChanged,
      ),
    );

    /* Rayout */
    return Row(children: [addButton(), textField()]);
  }
}
